import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef Future<bool> AuthFunction({bool onlySilently});

class AuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  FirebaseUser currentUser;

  AuthHelper() {
    _firebaseAuth.onAuthStateChanged.listen((user) {
      currentUser = user;
    });
  }

  bool get isLoggedIn => currentUser != null;

  Future<bool> tryRecoveringSession() async {
    final authFunctions = <AuthFunction>[signInWithGoogle, signInWithFacebook];

    for (var authFunction in authFunctions) {
      final result = await authFunction(onlySilently: true);

      if (result) {
        return true;
      }
    }

    return false;
  }

  Future<bool> signInWithGoogle({bool onlySilently = false}) async {
    final googleUser = await _signInWithGoogle(onlySilently);

    if (googleUser != null) {
      final firebaseUser = await _tryToLoginWithGoogle();
      return firebaseUser != null;
    }

    return false;
  }

  Future<bool> signInWithFacebook({bool onlySilently = false}) async {
    final facebookLoginResult = await _signInWithFacebook(onlySilently);

    if (facebookLoginResult != null) {
      final firebaseUser = await _tryToLoginWithFacebook(facebookLoginResult);
      return firebaseUser != null;
    }

    return false;
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<GoogleSignInAccount> _signInWithGoogle(bool onlySilently) async {
    var googleUser = _googleSignIn.currentUser;

    googleUser ??= await _googleSignIn.signInSilently();

    if (!onlySilently && googleUser == null) {
      googleUser = await _googleSignIn.signIn();
    }

    return googleUser;
  }

  Future<FacebookLoginResult> _signInWithFacebook(bool onlySilently) async {
    final result = await _facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        return result;
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw Exception('oops cancelled fb auth');
        break;
      case FacebookLoginStatus.error:
        throw Exception('oops fb auth error');
        break;
    }

    return null;
  }

  Future<FirebaseUser> _tryToLoginWithGoogle() async {
    final googleUser = _googleSignIn.currentUser;

    if (googleUser == null) {
      return null;
    }

    final googleAuth = await googleUser.authentication;
    final firebaseUser = await _firebaseAuth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return firebaseUser;
  }

  Future<FirebaseUser> _tryToLoginWithFacebook(
      FacebookLoginResult facebookLoginResult) async {
    final facebookAuthToken = facebookLoginResult.accessToken;
    final firebaseUser = await _firebaseAuth.signInWithFacebook(
        accessToken: facebookAuthToken.token);

    return firebaseUser;
  }
}
