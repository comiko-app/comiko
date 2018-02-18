import 'dart:async';
import 'dart:convert';

import 'package:comiko/account_drawer.dart';
import 'package:comiko/app_state.dart';
import 'package:comiko/auth_helper.dart';
import 'package:comiko/widgets/image_caching_loader.dart';
import 'package:comiko/widgets/page_view_wrapper.dart';
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
    combineReducers([reducer]),
    initialState: new AppState.initial(),
  );

  @override
  Widget build(BuildContext context) => new StoreProvider(
        store: store,
        child: new MaterialApp(
          title: 'Comiko',
          theme: new ThemeData.dark(),
          home: new MyHomePage(store: store),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  final Store<AppState> store;

  const MyHomePage({
    @required this.store,
    Key key,
  })
      : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState(store: store);
}

class _MyHomePageState extends State<MyHomePage> {
  final Store<AppState> store;
  final AuthHelper _authHelper = new AuthHelper();

  ImagesCachingLoader imagesCachingLoader;
  PageViewWrapper pageView;

  _MyHomePageState({
    @required this.store,
  }) {
    pageView = new PageViewWrapper(store: store);
    imagesCachingLoader = new ImagesCachingLoader(pageView);
  }

  Future<Null> initServices() async {
    final eventString = await rootBundle.loadString('lib/data/events.json');
    final List<Map<String, dynamic>> eventJson = JSON.decode(eventString);
    final JsonEventService service = ServiceProvider.get(EventService);
    service.init(eventJson); // ignore: cascade_invocations
    store.dispatch(new FetchEventsAction());
  }

  @override
  void initState() {
    super.initState();

    initServices();
    imagesCachingLoader.cacheArtistImages(context);
    _authHelper.tryRecoveringSession();
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        drawer: new AccountDrawer(
          authHelper: _authHelper,
        ),
        body: imagesCachingLoader,
        appBar: new AppBar(
            title: new Text(store.state.appTitle),
            actions: store.state.appActions(context)),
        bottomNavigationBar: new StoreConnector<AppState, int>(
          converter: (store) => store.state.currentPageIndex,
          builder: (context, pageIndex) => new BottomNavigationBar(
                items: [
                  const BottomNavigationBarItem(
                      icon: const Icon(Icons.event_available),
                      title: const Text("À venir")),
                  const BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite),
                    title: const Text('Favoris'),
                  ),
                  const BottomNavigationBarItem(
                      icon: const Icon(Icons.mic),
                      title: const Text("Artistes")),
                  const BottomNavigationBarItem(
                      icon: const Icon(Icons.insert_emoticon),
                      title: const Text("Comiko")),
                ],
                onTap: pageView.navigationTapped,
                currentIndex: pageIndex,
              ),
        ),
      );
}
