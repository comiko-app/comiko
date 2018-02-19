import 'package:comiko/app_state.dart';
import 'package:comiko/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AccountDrawer extends StatefulWidget {
  final AuthHelper authHelper;

  const AccountDrawer({
    @required this.authHelper,
  });

  @override
  _AccountDrawerState createState() =>
      new _AccountDrawerState(authHelper: authHelper);
}

class _AccountDrawerState extends State<AccountDrawer>
    with TickerProviderStateMixin {
  final AuthHelper authHelper;

  _AccountDrawerState({
    @required this.authHelper,
  });

  bool _showDrawerContents = true;

  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  void _rebuild() {
    setState(() {
      // Redraw widget
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    )
        .animate(
      new CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  UserAccountsDrawerHeader createUserAccountsDrawerHeader() {
    String displayName;
    String email;
    Widget accountPicture;

    if (authHelper.isLoggedIn) {
      displayName = authHelper.currentUser.displayName;
      email = authHelper.currentUser.email;
      accountPicture = new CircleAvatar(
        backgroundImage: new NetworkImage(authHelper.currentUser.photoUrl),
      );
    } else {
      displayName = 'Pas connecté';
      email = '';
    }

    return new UserAccountsDrawerHeader(
      accountName: new Text(displayName),
      accountEmail: new Text(email),
      currentAccountPicture: accountPicture,
      onDetailsPressed: () {
        _showDrawerContents = !_showDrawerContents;
        if (_showDrawerContents)
          _controller.reverse();
        else
          _controller.forward();
      },
    );
  }

  List<Widget> createAuthenticationListTiles() {
    if (authHelper.isLoggedIn) {
      return [
        new ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Se déconnecter'),
          onTap: () {
            authHelper.signOut().then((_) {
              _rebuild();
            });
          },
        ),
      ];
    } else {
      return [
        new ListTile(
          leading: const Icon(FontAwesomeIcons.google),
          title: const Text('Connectez-vous avec Google'),
          onTap: () {
            authHelper.signInWithGoogle().then((success) {
              if (success) {
                _rebuild();
              }
            });
          },
        ),
        new ListTile(
          leading: const Icon(FontAwesomeIcons.facebook),
          title: const Text('Connectez-vous avec Facebook'),
          onTap: () {
            authHelper.signInWithFacebook().then((success) {
              if (success) {
                _rebuild();
              }
            });
          },
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, Store<AppState>>(
        converter: (Store<AppState> store) => store,
        builder: (context, Store<AppState> store) => new Drawer(
              child: new ListView(
                children: <Widget>[
                  createUserAccountsDrawerHeader(),
                  new ClipRect(
                    child: new Stack(
                      children: <Widget>[
                        new FadeTransition(
                          opacity: _drawerContentsOpacity,
                        ),
                        new SlideTransition(
                          position: _drawerDetailsPosition,
                          child: new FadeTransition(
                            opacity:
                                new ReverseAnimation(_drawerContentsOpacity),
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: createAuthenticationListTiles(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      );
}
