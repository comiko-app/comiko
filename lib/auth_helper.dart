import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  FirebaseUser currentUser;
  bool get isLoggedIn => currentUser != null;

  AuthHelper() {
    _firebaseAuth.onAuthStateChanged.listen((FirebaseUser user) {
      currentUser = user;
    });
  }

  Future<bool> signIn({bool onlySilently = false}) async {
    final googleUser = await _signInWithGoogle(onlySilently);

    if (googleUser != null) {
      final firebaseUser = await _tryToLoginWithGoogle();
      return firebaseUser != null;
    }

    return false;
  }

  Future<GoogleSignInAccount> signOut() => _firebaseAuth.signOut();

  Future<GoogleSignInAccount> _signInWithGoogle(bool onlySilently) async {
    var googleUser = _googleSignIn.currentUser;

    if (googleUser == null) {
      googleUser = await _googleSignIn.signInSilently();
    }

    if (!onlySilently && googleUser == null) {
      googleUser = await _googleSignIn.signIn();
    }

    return googleUser;
  }

  Future<FirebaseUser> _tryToLoginWithGoogle() async {
    var googleUser = _googleSignIn.currentUser;

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
}
