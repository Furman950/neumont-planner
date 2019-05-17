import 'package:flutter/material.dart';
import 'package:neumont_planner/views/day_view.dart';

import 'managers/view_manager.dart';
import 'pages/login.dart';
import 'pages/settings.dart';

enum View{
  MONTH,
  WEEK,
  DAY,
  HOUR
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neumont Planner',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Neumont Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  View _currentView = View.MONTH;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Developer'),
              accountEmail: new Text('dev@planner.neumont.edu'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://www.neumont.edu/cmsimages/neumont_logo.png'),
              ),
            ),
            new ListTile(
                title: new Text('Settings'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>new SettingsPage()));
                }),
            new ListTile(
                title: new Text('Login'),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginPage()));
                }),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
                  ViewManager(),
                  DayView()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add Event',
        child: Icon(Icons.add),
      ), 
    );
  }
}
