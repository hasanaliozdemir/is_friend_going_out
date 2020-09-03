import 'package:flutter/material.dart';
import 'package:is_friend_going_out/service/services.dart';
import 'package:is_friend_going_out/view/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: AuthService().authenticated,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo App',
        theme: ThemeData.dark(),
        home: Wrapper(),
      ),
    );
  }
}
