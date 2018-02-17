import 'dart:async';
import 'dart:convert';

import 'package:async_loader/async_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comiko/account_drawer.dart';
import 'package:comiko/app_state.dart';
import 'package:comiko/auth_helper.dart';
import 'package:comiko/pages/about_us_page.dart';
import 'package:comiko/pages/artists_page.dart';
import 'package:comiko/pages/liked_events_page.dart';
import 'package:comiko/pages/upcoming_events_page.dart';
import 'package:comiko/widgets/bottom_bar.dart';
import 'package:comiko/widgets/navigation_icon_view.dart';
import 'package:comiko_backend/services.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  static final Store<AppState> store = new Store(
    combineReducers([reducer as Reducer]),
    initialState: new AppState.initial(),
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Comiko',
        theme: new ThemeData.dark(),
        home: new MyHomePage(title: 'Flutter Demo Home Page', store: store),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Store<AppState> store;
  final String title;

  MyHomePage({
    Key key,
    this.title,
    @required this.store,
  })
      : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState(store: store);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Completer _areImagesCached = new Completer();

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  final Store<AppState> store;
  final AuthHelper _authHelper = new AuthHelper();
  List<NavigationIconView> navigationViews;

  _MyHomePageState({
    @required this.store,
  });

  Future<Null> initServices() async {
    String eventString = await rootBundle.loadString('lib/data/events.json');
    List<Map<String, dynamic>> eventJson = JSON.decode(eventString);
    JsonEventService service = ServiceProvider.get(EventService);
    service.init(eventJson);
    store.dispatch(new FetchEventsAction());
  }

  @override
  void initState() {
    super.initState();

    buildNavigationViews();
    initServices();
    cacheArtistImages();
    _authHelper.tryRecoveringSession();
  }

  void buildNavigationViews() {
    navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.event_available),
        body: new UpcomingEventsPage(store: store),
        title: const Text('À venir'),
        color: new Color.fromARGB(0xFF, 0xF4, 0x43, 0x36),
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.favorite),
        body: new LikedEventsPage(store: store),
        title: const Text('Favoris'),
        color: new Color.fromARGB(0xFF, 0x00, 0xBC, 0xD4),
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.mic),
        body: new ArtistsPage(),
        title: const Text('Artistes'),
        color: new Color.fromARGB(0xFF, 0x75, 0x75, 0x75),
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.insert_emoticon),
        body: new AboutUsPage(),
        title: const Text('Comiko'),
        color: new Color.fromARGB(0xFF, 0xD3, 0x2F, 0x2F),
        vsync: this,
      ),
    ];

    for (NavigationIconView view in navigationViews) {
      view.controller.addListener(_rebuild);
    }

    navigationViews[0].controller.value = 1.0;
  }

  Future<Null> cacheArtistImages() async {
    var snapshot = await Firestore.instance
        .collection('artists')
        .where("deleted", isEqualTo: false)
        .orderBy('name', descending: false)
        .snapshots
        .first;

    var cachedImages = <Future>[];
    for (var d in snapshot.documents) {
      final artist = new Artist.fromJson(d.data);
      if (artist.imageUrl == null) {
        print("${artist.name} has no picture!");
        continue;
      }
      final imageProvider = new CachedNetworkImageProvider(artist.imageUrl);
      cachedImages.add(precacheImage(imageProvider, context));
    }

    await Future.wait(cachedImages);

    _areImagesCached.complete();
    _asyncLoaderState.currentState.reloadState();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in navigationViews) {
      transitions.add(view.transition(context));
    }

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () => _areImagesCached.future,
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) => new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: new Icon(
                    Icons.error_outline,
                    size: 72.0,
                  )),
              const Text(
                  "Une erreur est survenue en chargeant l'application :("),
            ],
          ),
      renderSuccess: ({data}) => _buildTransitionsStack(),
    );

    return new Scaffold(
      drawer: new AccountDrawer(
        authHelper: _authHelper,
      ),
      body: new Center(child: _asyncLoader),
      bottomNavigationBar: new BottomBar(
        navigationViews: navigationViews,
      ),
    );
  }
}
