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

  GoogleSignInAccount get currentUser => _googleSignIn.currentUser;

  Future<bool> signIn({bool onlySilently = false}) async {
    final googleUser = await _signInWithGoogle(onlySilently);

    if (googleUser != null) {
      final firebaseUser = await _signInToFirebase();
      return firebaseUser != null;
    }

    return false;
  }

  Future<GoogleSignInAccount> signOut() async {
    return await _googleSignIn.signOut();
  }

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

  Future<FirebaseUser> _signInToFirebase() async {
    var googleUser = _googleSignIn.currentUser;

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final FirebaseUser firebaseUser = await _firebaseAuth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return firebaseUser;
  }
}
