import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Email Address:'),
            TextField(),
            Text('Password:'),
            TextField(),
            RaisedButton(
              child: const Text('Login'),
              elevation: 4.0,
              splashColor: Colors.redAccent,
              onPressed: null,
            )
          ],
        )
      )
    );
  }
}