import 'dart:async';
import 'dart:convert';

import 'package:comiko/account_drawer.dart';
import 'package:comiko/app_state.dart';
import 'package:comiko/auth_helper.dart';
import 'package:comiko/pages/about_us_page.dart';
import 'package:comiko/pages/artists_page.dart';
import 'package:comiko/pages/is_page.dart';
import 'package:comiko/pages/upcoming_events_page.dart';
import 'package:comiko/widgets/image_caching_loader.dart';
import 'package:comiko_backend/services.dart';
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
  int _page = 0;
  PageController _pageController;

  final Store<AppState> store;
  final AuthHelper _authHelper = new AuthHelper();

  ImagesCachingLoader imagesCachingLoader;
  List<IsPage> _pages;

  _MyHomePageState({
    @required this.store,
  }) {
    _pageController = new PageController();

    _pages = [
      new UpcomingEventsPage(store: store),
      new ArtistsPage(),
      new AboutUsPage(),
    ];

    final _pageView = new PageView(
      children: _pages,
      controller: _pageController,
      onPageChanged: (index) => onPageChanged(context, index),
    );

    imagesCachingLoader = new ImagesCachingLoader(_pageView);
  }

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

    store.dispatch(new PageChangedAction(_pages[_pageController.initialPage]));

    initServices();
    imagesCachingLoader.cacheArtistImages(context);
    _authHelper.tryRecoveringSession();
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void onPageChanged(BuildContext context, int page) {
    setState(() {
      this._page = page;
      store.dispatch(new PageChangedAction(_pages[page]));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new AccountDrawer(
        authHelper: _authHelper,
      ),
      body: imagesCachingLoader,
      appBar: new AppBar(
          title: new Text(store.state.appTitle),
          actions: store.state.appActions(context)),
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
