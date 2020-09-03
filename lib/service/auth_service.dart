import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Is authenticated stream for wrapper
  Stream<bool> get authenticated {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => user != null);
  }

  /// User ID stream
  Stream<String> get userId {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => user.uid ?? null);
  }

  /// Get Current User ID
  Future getCurrentUserId() async {
    return await _auth.currentUser().then((value) => value.uid);
  }

  /// Sign In With Email and Password
  Future signInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } catch (e) {
      return e;
    }
  }

  ///Register with Email, Password and Create Data with Gender, Name, Username
  Future registerWithEmailAndPassword({
    String gender,
    String name,
    String username,
    String email,
    String password,
  }) async {
    int usernameEmpty = await DataService().checkUserName(username: username);

    if (usernameEmpty != 0) {
      return PlatformException(
        code: 'username_exist',
        details: 'This username exist, Please choose another username',
        message: 'This username exist, Please choose another username',
      );
    }

    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = result.user.uid;

      await DataService().createUserData(
        uid: uid,
        name: name,
        username: username,
        gender: gender,
      );

      return result.user;
    } catch (e) {
      return e;
    }
  }

  /// Send Password Reset MAil By Email
  Future forgetPassword({String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return e;
    }
  }

  /// Sign Out Function
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return e;
    }
  }
}
