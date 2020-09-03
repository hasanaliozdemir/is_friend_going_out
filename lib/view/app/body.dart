import 'package:flutter/material.dart';
import 'package:is_friend_going_out/model/models.dart';
import 'package:is_friend_going_out/service/services.dart';
import 'package:is_friend_going_out/view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../service/data_service.dart';

class BodyScreen extends StatefulWidget {
  BodyScreen({Key key}) : super(key: key);

  @override
  _BodyScreenState createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  String userName = '';
  _BodyScreenState(){
    getGoingOut().then((val) => setState(() {
      userName = val;
    }));
  } 
  var goingOut = DataService().usersCollection.document().get();
  @override
  Widget build(BuildContext context) {
    final List<Room> rooms = Provider.of<List<Room>>(context) ?? List<Room>();

    return Container(
      child: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(
              padding: EdgeInsets.only(left: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.green,
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.red[400],
            ),
            key: Key(index.toString()),
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Confirmation"),
                      content: const Text(
                          "Are you sure you want to delete this item?"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              DataService()
                                  .removeUserFromRoom(room: rooms[index]);
                              Navigator.of(context).pop(true);
                            },
                            child: const Text("Delete")),
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
              }
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title:  const Text("Add User"),
                    content: Theme(
                      data: new ThemeData.dark().copyWith(
                        accentColor: Colors.white54,
                      ),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          DataService().addUserToRoom(
                            room: rooms[index],
                            username: value,
                          );
                          Navigator.of(context).pop(false);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.group,
                            color: Colors.green[200],
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: ExpansionTile(
              leading: Icon(
                Icons.group,
                // TODO: Color from database
                color: Colors.white,
              ),
              title: Text(
                rooms[index].name,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              children: _buildTiles(rooms[index]),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildTiles(Room room) {
    return room.status.map((Status status) {
      return Column(
        children: [
          Divider(
            height: 0.0,
            endIndent: 15.0,
            indent: 15.0,
            thickness: 2.0,
          ),
          Container(
            color: Colors.black12,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
              title: Text(status.name),
              leading: ProfileAvatar(
                isActive: status.goingOut,
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSnDWT7GlY2ZBbiPGz6XqwUbtKmUijsdEamxw&usqp=CAU',
              ),
              subtitle: status.goingOut ? Text(status.goingWhere) : null,
              trailing: status.goingOut
                  ? Icon(status.haveCar
                      ? Icons.directions_car
                      : Icons.directions_walk)
                  : null,
            ),
          ),
        ],
      );
    }).toList();
  }

  Future getUserState() async {
    var user = DataService().getCurrentUser();
    return user;
  }

  Future<String> getGoingOut() async {
    var user = await getUserState();
    return user.name.toString();
  }
}
