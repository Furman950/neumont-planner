import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings Page'),
      ),
      body: Column(
        children: <Widget>[
          new ListTile(
            title: new Text('Object 1'),
            onTap: () => print('Object 1 Pressed'),
          ),
          new ListTile(
            title: new Text('Object 2'),
            onTap: () => print('Object 2 Pressed'),
          ),
          new ListTile(
            title: new Text('Object 3'),
            onTap: () => print('Object 3 Pressed'),
          ),
        ],
      ),
    );
  }
}