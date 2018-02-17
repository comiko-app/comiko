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
import 'package:comiko/pages/is_page.dart';
import 'package:comiko/pages/upcoming_events_page.dart';
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
        home: new MyHomePage(store: store),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Store<AppState> store;

  MyHomePage({
    Key key,
    @required this.store,
  })
      : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState(store: store);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Completer _areImagesCached = new Completer();
  int _page = 0;
  PageController _pageController;

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  final Store<AppState> store;
  final AuthHelper _authHelper = new AuthHelper();
  List<IsPage> pages;

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
    pages = [
      new UpcomingEventsPage(store: store),
      new ArtistsPage(),
      new AboutUsPage(),
    ];

    _pageController = new PageController();

    initServices();
    cacheArtistImages();
    _authHelper.tryRecoveringSession();
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

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void onPageChanged(BuildContext context, int page) {
    setState(() {
      this._page = page;
      store.dispatch(new PageChangedAction(context, pages[page]));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () => _areImagesCached.future,
      renderLoad: () => new Center(child: new CircularProgressIndicator()),
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
      renderSuccess: ({data}) {
        return new PageView(
          children: pages,
          controller: _pageController,
          onPageChanged: (index) => onPageChanged(context, index),
        );
      },
    );

    return new Scaffold(
      drawer: new AccountDrawer(
        authHelper: _authHelper,
      ),
      body: _asyncLoader,
      appBar: new AppBar(
        title: new Text(store.state.appTitle),
        actions: store.state.appActions,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.event_available),
              title: new Text("À venir")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.mic), title: new Text("Artistes")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.insert_emoticon), title: new Text("Comiko")),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
