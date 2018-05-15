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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final Store<AppState> store = Store<AppState>(
    combineReducers([reducers()]),
    initialState: AppState.initial(),
  );

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Comiko',
          theme: ThemeData.dark(),
          home: MyHomePage(),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthHelper _authHelper = AuthHelper();

  ImagesCachingLoader imagesCachingLoader;
  PageViewWrapper pageView;

  _MyHomePageState() {
    pageView = PageViewWrapper();
    imagesCachingLoader = ImagesCachingLoader(pageView);
  }

  Future<Null> initServices(Store store) async {
    final eventString = await rootBundle.loadString('lib/data/events.json');
    final eventJson = json.decode(eventString);
    final JsonEventService service = ServiceProvider.get(EventService);
    service.init(eventJson); // ignore: cascade_invocations
    store.dispatch(FetchEventsAction());
  }

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, Store<AppState>>(
        onInit: (Store<AppState> store) {
          _authHelper.tryRecoveringSession();
          initServices(store);

          imagesCachingLoader.cacheArtistImages(context);
        },
        converter: (Store<AppState> store) => store,
        builder: (context, Store<AppState> store) => Scaffold(
              drawer: AccountDrawer(
                authHelper: _authHelper,
              ),
              body: imagesCachingLoader,
              appBar: AppBar(
                  title: Text(store.state.appTitle),
                  actions: store.state.appActions(context)),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.event_available),
                      title: Text("À venir")),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    title: Text('Favoris'),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.mic), title: Text("Artistes")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.insert_emoticon), title: Text("Comiko")),
                ],
                onTap: pageView.navigationTapped,
                currentIndex: store.state.currentPageIndex,
              ),
            ),
      );
}
