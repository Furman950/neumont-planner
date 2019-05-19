import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode username = FocusNode();
  FocusNode password = FocusNode();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  focusNode: username,
                  textAlign: TextAlign.left,
                  autocorrect: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  textInputAction: TextInputAction.continueAction,
                ),
              ),
              new ListTile(
                title: new TextField(
                  focusNode: password,
                  textAlign: TextAlign.left,
                  autocorrect: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.send,
                ),
              ),
              RaisedButton(
                child: const Text('Login'),
                elevation: 4.0,
                splashColor: Colors.redAccent,
                onPressed: null,
              )
            ],
          )
        )
      )
    );
  }
}