import 'package:dribbler_v2/screen/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // SignIn handler
  void signIn() async {
    final formstate = _formKey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        // AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Sign In"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please type email';
                }
              },
              onSaved: (input) => {_email = input},
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              validator: (input) {
                if (input.length < 6) {
                  return 'Please type more than 6 length password';
                }
              },
              obscureText: true,
              onSaved: (input) => {_password = input},
              decoration: InputDecoration(labelText: 'Password'),
            ),
            Center(
              child: new RaisedButton(
                child: new Text("Sign In"),
                onPressed: () {
                  signIn();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
