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
      _AccountDrawerState(authHelper: authHelper);
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
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = Tween<Offset>(
      begin: Offset(0.0, -1.0),
      end: Offset.zero,
    )
        .animate(
      CurvedAnimation(
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
      accountPicture = CircleAvatar(
        backgroundImage: NetworkImage(authHelper.currentUser.photoUrl),
      );
    } else {
      displayName = 'Pas connecté';
      email = '';
    }

    return UserAccountsDrawerHeader(
      accountName: Text(displayName),
      accountEmail: Text(email),
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
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Se déconnecter'),
          onTap: () {
            authHelper.signOut().then((_) {
              _rebuild();
            });
          },
        ),
      ];
    } else {
      return [
        ListTile(
          leading: Icon(FontAwesomeIcons.google),
          title: Text('Connectez-vous avec Google'),
          onTap: () {
            authHelper.signInWithGoogle().then((success) {
              if (success) {
                _rebuild();
              }
            });
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.facebook),
          title: Text('Connectez-vous avec Facebook'),
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
      StoreConnector<AppState, Store<AppState>>(
        converter: (Store<AppState> store) => store,
        builder: (context, Store<AppState> store) => Drawer(
              child: ListView(
                children: <Widget>[
                  createUserAccountsDrawerHeader(),
                  ClipRect(
                    child: Stack(
                      children: <Widget>[
                        FadeTransition(
                          opacity: _drawerContentsOpacity,
                        ),
                        SlideTransition(
                          position: _drawerDetailsPosition,
                          child: FadeTransition(
                            opacity: ReverseAnimation(_drawerContentsOpacity),
                            child: Column(
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
