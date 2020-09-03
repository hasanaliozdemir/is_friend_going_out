import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_friend_going_out/model/models.dart';
import 'package:is_friend_going_out/service/services.dart';
import 'package:is_friend_going_out/view/app/body.dart';
import 'package:is_friend_going_out/view/app/drawer.dart';
import 'package:is_friend_going_out/view/app/floating.dart';
import 'package:provider/provider.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<String>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Nereye Gidioz',
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.headline5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        drawer: DrawerScreen(),
        body: StreamProvider<List<Room>>.value(
          value: DataService(userId: userId).rooms,
          child: BodyScreen(),
        ),
        floatingActionButton: FloatingActionButtonScreen(),
        bottomSheet: SizedBox(
                  height: 80,
                  child: Container(
                              color: Colors.yellow,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                              ],),
                                  ),
                            ),
      ),
    );
  }
}
