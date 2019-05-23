import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects.dart';
import 'package:neumont_planner/views/day_view.dart';
import 'package:neumont_planner/views/month_view.dart';

import 'managers/view_manager.dart';
import 'pages/login.dart';
import 'pages/settings.dart';
import 'views/hour_view.dart';
import 'views/week_view.dart';

enum View { MONTH, WEEK, DAY, HOUR }

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
  View _currentViewType = View.HOUR;
  DateTime _today = DateTime.now();
  DateTime _selectedDate  = DateTime.now();
  List<Assignment> _assignments = [];
  List<Course> _courses = [];
  List<Event> _events = [];

  Widget getView(View view, Function(View,DateTime) changeView) {

  if (view == View.DAY) {
    return DayView(_assignments, _courses, _events, changeView);
  } else if (view == View.HOUR) {
    return HourView(_assignments, _courses, _events, changeView);
  } else if (view == View.WEEK) {
    return WeekView(_assignments, _courses, _events, changeView);
  } else if (view == View.MONTH) {
    return MonthView();
  } else {
    return Text('Yikes');
  }
}

  void changeView(View view, DateTime newDate) {
    _assignments.clear();
    _courses.clear();
    _events.clear();
    setState(() {
      _currentViewType = view;
      //simulates Assignment api call;
      for(int i = 0; i < 10 ; i++){
        _assignments.add( new Assignment(i, "Assignment " + i.toString(), "This is worth alotta points", 25.0, DateTime.now(), false));
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: <Widget>[
      //       new UserAccountsDrawerHeader(
      //         accountName: new Text('Developer'),
      //         accountEmail: new Text('dev@planner.neumont.edu'),
      //         currentAccountPicture: new CircleAvatar(
      //           backgroundImage: new NetworkImage('https://www.neumont.edu/cmsimages/neumont_logo.png'),
      //         ),
      //       ),
      //       new ListTile(
      //         title: new Text('Settings'),
      //         onTap: () {
      //           Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>new SettingsPage()));
      //           }
      //         ),
      //       new ListTile(
      //         title: new Text('Login'),
      //         onTap: () {
      //           Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new LoginPage()));
      //         }
      //       ),
      //     ],
      //   ),
      // ),
      body: Center(
        child: Column(
          children: <Widget>[
            ViewManager(changeView, _selectedDate),
            getView(_currentViewType, changeView),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: null,
      //   tooltip: 'Add Event',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
