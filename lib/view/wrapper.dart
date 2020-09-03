import 'package:flutter/material.dart';
import 'package:is_friend_going_out/service/services.dart';
import 'package:is_friend_going_out/view/app/app.dart';
import 'package:is_friend_going_out/view/auth/auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authenticated = Provider.of<bool>(context) ?? false;

    return !authenticated
        ? AuthWrapper()
        : StreamProvider<String>.value(
            value: AuthService().userId,
            child: AppWrapper(),
          );
  }
}
