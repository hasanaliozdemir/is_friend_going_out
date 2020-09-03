import 'package:flutter/material.dart';
import 'package:is_friend_going_out/service/services.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Drawer(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Spacer(),
              FlatButton.icon(
                icon: Icon(Icons.phonelink_erase),
                onPressed: () async {
                  await _auth.signOut();
                },
                label: Text('logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
