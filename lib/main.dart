import 'dart:async';
import 'dart:convert';

import 'package:comiko/account_drawer.dart';
import 'package:comiko/app_state.dart';
import 'package:comiko/auth_helper.dart';
import 'package:comiko/pages/is_page.dart';
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

  Store<AppState> store;
  ImagesCachingLoader imagesCachingLoader;
  PageViewWrapper pageView;

  String appTitle;
  AppActionsFactory appActions;

  _MyHomePageState() {
    appTitle = AppState.defaultAppTitle;
    appActions = AppState.defaultAppActions;

    pageView = new PageViewWrapper();
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

    _authHelper.tryRecoveringSession();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    initServices();
    imagesCachingLoader.cacheArtistImages(context);

    store = new StoreProvider.of(context).store;
    store.onChange.listen((state) {
      setState(() {
        appTitle = state.appTitle;
        appActions = state.appActions;
      });
    });
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        drawer: new AccountDrawer(
          authHelper: _authHelper,
        ),
        body: imagesCachingLoader,
        appBar:
            new AppBar(title: new Text(appTitle), actions: appActions(context)),
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
