import 'package:flutter/material.dart';
import 'package:is_friend_going_out/view/auth/loginPage.dart';
import 'package:is_friend_going_out/view/auth/registerPage.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn)
      return LoginPage(toggleView: toggleView);
    else
      return RegisterPage(toggleView: toggleView);
  }
}
