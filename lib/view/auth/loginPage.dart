import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_friend_going_out/service/services.dart';
import 'package:is_friend_going_out/view/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  LoginPage({
    Key key,
    @required this.toggleView,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //text field states
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
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 10),
                  //   alignment: Alignment.centerRight,
                  //   child: Text(
                  //     'Forgot Password ?',
                  //     style: TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  _createAccountLabel(),
                  _errorText(),
                  SizedBox(height: 60),
                ],
              ),
            ),
          );
  }

  Widget _errorText() {
    return Container(
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
              style: TextStyle(color: Colors.white),
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
                } else if (val.isEmpty) {
                  return '$title can note be null';
                } else {
                  return null;
                }
              },
              onChanged: (val) {
                if (title == 'Email') {
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

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          setState(() => loading = true);
          dynamic result = await _auth.signInWithEmailAndPassword(
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
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
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
              'Don\'t have an account ?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
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
          _entryField("Email"),
          _entryField("Password", isPassword: true),
        ],
      ),
    );
  }
}
