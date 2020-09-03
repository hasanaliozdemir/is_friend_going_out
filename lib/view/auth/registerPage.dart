import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_friend_going_out/service/services.dart';
import 'package:is_friend_going_out/view/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;

  RegisterPage({
    Key key,
    @required this.toggleView,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //text field states
  String gender;
  String name = '';
  String username = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xff18191b),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .1),
                  AuthTitle(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  _loginAccountLabel(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      error,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
              ),
            ),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 10),
          Theme(
            data: ThemeData.dark().copyWith(
              accentColor: Colors.blue[800],
              hintColor: Colors.transparent,
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              obscureText: isPassword,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                fillColor: Color(0xff323232),
                filled: true,
              ),
              validator: (val) {
                if (title == 'Password' && val.length < 6) {
                  return 'Enter a password more then 6 characters';
                } else if (title == 'Username' && val.length < 5) {
                  return 'Enter a username more then 5 characters';
                } else if (title == 'Username' && val.length > 15) {
                  return 'Enter a username less then 15 characters';
                } else if (title == "Username" && gender == null) {
                  return '';
                } else if (val.isEmpty) {
                  return '$title can note be null';
                } else {
                  return null;
                }
              },
              onChanged: (val) {
                if (title == 'Name') {
                  setState(() => name = val);
                } else if (title == 'Username') {
                  setState(() => username = val);
                } else if (title == 'Email') {
                  setState(() => email = val);
                } else if (title == 'Password') {
                  setState(() => password = val);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _dropDownGender(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 10),
          Theme(
            data: ThemeData.dark().copyWith(
              accentColor: Colors.blue[800],
              hintColor: Colors.transparent,
            ),
            child: DropdownButtonFormField<String>(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                fillColor: Color(0xff323232),
                filled: true,
              ),
              validator: (val) {
                if (val == null) {
                  return 'Choose a gender';
                } else if (username == '') {
                  return '';
                } else {
                  return null;
                }
              },
              dropdownColor: Color(0xff323232),
              isExpanded: true,
              hint: Text(
                'Gender',
                style: TextStyle(color: Colors.white),
              ),
              iconEnabledColor: Colors.white,
              items: [
                DropdownMenuItem(
                  child: Text(
                    'Male',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'Male',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Female',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'Female',
                ),
                DropdownMenuItem(
                  child: Text(
                    'Other',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: 'Other',
                ),
              ],
              value: gender,
              onChanged: (String value) {
                setState(() {
                  gender = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          setState(() => loading = true);
          dynamic result = await _auth.registerWithEmailAndPassword(
            gender: gender,
            name: name,
            username: username,
            email: email,
            password: password,
          );
          if (result.runtimeType == PlatformException) {
            setState(() {
              loading = false;
              error = result.message;
            });
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xff14244f),
        ),
        child: Text(
          'Register',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        widget.toggleView();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _entryField('Name'),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _entryField('Username'),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: _dropDownGender('Gender'),
              ),
            ],
          ),
          _entryField('Email'),
          _entryField('Password', isPassword: true),
        ],
      ),
    );
  }
}
