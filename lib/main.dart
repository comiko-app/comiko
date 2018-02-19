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
import 'package:redux/redux.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  static final Store<AppState> store = new Store<AppState>(
    combineReducers([reducer]),
    initialState: new AppState.initial(),
  );

  @override
  Widget build(BuildContext context) => new StoreProvider(
        store: store,
        child: new MaterialApp(
          title: 'Comiko',
          theme: new ThemeData.dark(),
          home: const MyHomePage(),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
  })
      : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthHelper _authHelper = new AuthHelper();

  ImagesCachingLoader imagesCachingLoader;
  PageViewWrapper pageView;

  _MyHomePageState() {
    pageView = new PageViewWrapper();
    imagesCachingLoader = new ImagesCachingLoader(pageView);
  }

  Future<Null> initServices(Store store) async {
    final eventString = await rootBundle.loadString('lib/data/events.json');
    final List<Map<String, dynamic>> eventJson = JSON.decode(eventString);
    final JsonEventService service = ServiceProvider.get(EventService);
    service.init(eventJson); // ignore: cascade_invocations
    store.dispatch(new FetchEventsAction());
  }

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, Store<AppState>>(
        onInit: (Store<AppState> store) {
          _authHelper.tryRecoveringSession();
          initServices(store);

          imagesCachingLoader.cacheArtistImages(context);
        },
        converter: (Store<AppState> store) => store,
        builder: (context, Store<AppState> store) => new Scaffold(
              drawer: new AccountDrawer(
                authHelper: _authHelper,
              ),
              body: imagesCachingLoader,
              appBar: new AppBar(
                  title: new Text(store.state.appTitle),
                  actions: store.state.appActions(context)),
              bottomNavigationBar: new BottomNavigationBar(
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
                currentIndex: store.state.currentPageIndex,
              ),
            ),
      );
}
