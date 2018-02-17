import 'dart:async';
import 'dart:convert';

import 'package:comiko/account_drawer.dart';
import 'package:comiko/app_state.dart';
import 'package:comiko/auth_helper.dart';
import 'package:comiko/widgets/comiko_page_view.dart';
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
    String eventString = await rootBundle.loadString('lib/data/events.json');
    List<Map<String, dynamic>> eventJson = JSON.decode(eventString);
    JsonEventService service = ServiceProvider.get(EventService);
    service.init(eventJson);
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
  Widget build(BuildContext context) {
    return new Scaffold(
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
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.event_available),
                    title: new Text("À venir")),
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.mic), title: new Text("Artistes")),
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.insert_emoticon),
                    title: new Text("Comiko")),
              ],
              onTap: pageView.navigationTapped,
              currentIndex: pageIndex,
            ),
      ),
    );
  }
}
