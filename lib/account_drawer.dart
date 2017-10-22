import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class AccountDrawer extends StatefulWidget {
  @override
  _AccountDrawerState createState() => new _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer>
    with TickerProviderStateMixin {
  bool _showDrawerContents = true;

  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  Future<FirebaseUser> _signInSilentlyWithGoogle() async {
    var googleUser = _googleSignIn.currentUser;
    if (googleUser == null) {
      await _googleSignIn.signInSilently();
    }

    if (googleUser != null) {
      return await _auth.currentUser();
    }

    return null;
  }

  Future<FirebaseUser> _signInWithGoogle() async {
    var googleUser = _googleSignIn.currentUser;
    if (googleUser == null) {
      googleUser = await _googleSignIn.signInSilently();
    }
    if (googleUser == null) {
      googleUser = await _googleSignIn.signIn();
    }

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final FirebaseUser user = await _auth.signInWithGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      return currentUser;
    }

    return null;
  }

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

    _signInSilentlyWithGoogle().then((user) {
      if (user != null) {
        _rebuild();
      }
    });
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
            accountName: new Text(_googleSignIn.currentUser != null
                ? _googleSignIn.currentUser.displayName
                : "Not logged in"),
            accountEmail: new Text(_googleSignIn.currentUser != null
                ? _googleSignIn.currentUser.email
                : ""),
            currentAccountPicture: _googleSignIn.currentUser != null
                ? new CircleAvatar(
                    backgroundImage:
                        new NetworkImage(_googleSignIn.currentUser.photoUrl),
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
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new ListTile(
                        leading: new CircleAvatar(child: new Text("E")),
                        title: new Text('Example item'),
                        onTap: null,
                      ),
                    ],
                  ),
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
                        _googleSignIn.currentUser == null
                            ? new ListTile(
                                leading: const Icon(Icons.account_box),
                                title: new Text('Sign in with google'),
                                onTap: () {
                                  _signInWithGoogle().then((account) {
                                    _rebuild();
                                  });
                                },
                              )
                            : new ListTile(
                                leading: const Icon(Icons.exit_to_app),
                                title: new Text('Log out'),
                                onTap: () {
                                  _googleSignIn.signOut().then((account) {
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
