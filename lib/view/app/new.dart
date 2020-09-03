import 'package:flutter/material.dart';
import 'package:is_friend_going_out/service/services.dart';

class NewGroupEntry extends StatefulWidget {
  NewGroupEntry({Key key}) : super(key: key);

  @override
  _NewGroupEntryState createState() => _NewGroupEntryState();
}

class _NewGroupEntryState extends State<NewGroupEntry> {
  final _formKey = GlobalKey<FormState>();
  var _userController = TextEditingController();

  List<String> users = List<String>();
  String groupName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff101010),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            dynamic currentUser = await DataService().getCurrentUser();
            users.add(currentUser.username);
            await DataService().createRoomData(name: groupName, users: users);
            Navigator.pop(context);
          }
        },
      ),
      appBar: AppBar(
        title: Text('Create New Group'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Theme(
                data: ThemeData.dark().copyWith(
                  accentColor: Colors.blue[800],
                  hintColor: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      'Group Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                      ),
                      validator: (val) {
                        if (val.length == 0)
                          return 'Enter a group name';
                        else if (val.length > 30)
                          return 'Enter a group name less then 30 character';
                        else
                          return null;
                      },
                      onChanged: (value) {
                        setState(() => groupName = value);
                      },
                      maxLength: 30,
                    ),
                    Text(
                      'Users',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _userController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                users.add(_userController.text);
                              });
                              _userController.clear();
                            }
                          },
                        ),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                      ),
                      validator: (val) {
                       if(users.length ==0)
                          if (val.length == 0)
                            return 'Enter username';
                          else if (val.length < 5)
                            return 'Enter a username more then 5 character';
                          else
                            return null;
                        else
                          return null;
                      },
                      //onChanged: (value) {
                        //setState(() => groupName = value);
                      //},
                      maxLength: 15,
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Column(
                      children: users
                          .map(
                            (user) => ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              title: Text(
                                user,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    setState(() {
                                      users.removeWhere(
                                          (element) => element == user);
                                    });
                                  }),
                            ),
                          )
                          .toList()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
