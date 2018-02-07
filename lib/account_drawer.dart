import 'package:comiko/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AccountDrawer extends StatefulWidget {
  final AuthHelper authHelper;

  AccountDrawer({
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

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(authHelper.currentUser != null
                ? authHelper.currentUser.displayName
                : "Pas connecté"),
            accountEmail: new Text(authHelper.currentUser != null
                ? authHelper.currentUser.email
                : ""),
            currentAccountPicture: authHelper.currentUser != null
                ? new CircleAvatar(
                    backgroundImage:
                        new NetworkImage(authHelper.currentUser.photoUrl),
                  )
                : null,
            onDetailsPressed: () {
              _showDrawerContents = !_showDrawerContents;
              if (_showDrawerContents)
                _controller.reverse();
              else
                _controller.forward();
            },
          ),
          new ClipRect(
            child: new Stack(
              children: <Widget>[
                // The initial contents of the drawer.
                new FadeTransition(
                  opacity: _drawerContentsOpacity,
                  child: new Text(''),
                ),
                // The drawer's "details" view.
                new SlideTransition(
                  position: _drawerDetailsPosition,
                  child: new FadeTransition(
                    opacity: new ReverseAnimation(_drawerContentsOpacity),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        authHelper.currentUser == null
                            ? new ListTile(
                                leading: const Icon(Icons.account_box),
                                title: new Text('Connectez-vous avec google'),
                                onTap: () {
                                  authHelper.signIn().then((success) {
                                    if (success) {
                                      _rebuild();
                                    }
                                  });
                                },
                              )
                            : new ListTile(
                                leading: const Icon(Icons.exit_to_app),
                                title: new Text('Se déconnecter'),
                                onTap: () {
                                  authHelper.signOut().then((account) {
                                    _rebuild();
                                  });
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
