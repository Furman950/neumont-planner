import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/views/day_view.dart';
import 'package:neumont_planner/views/hour_view.dart';
import 'package:neumont_planner/views/month_view.dart';
import 'package:neumont_planner/views/week_view.dart';

import 'models/objects/Course.dart';
import 'models/objects/assignment.dart';
import 'models/objects/custom_event.dart';
import 'views/view_manager.dart';


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
  FlutterLocalNotificationsPlugin _localNotification;

  @override
  void initState() {
    super.initState();

    _localNotification = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    _localNotification.initialize(initSettings);
  }

  View _currentViewType = View.MONTH;
  DateTime _today = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  List<Assignment> _assignments = [];
  List<Course> _courses = [];
  List<CustomEvent> _events = [];

  Widget getView(View view, Function(View, DateTime) changeView) {
    if (view == View.DAY && _selectedDate.day == _today.day) {
      return HourView(_assignments, _courses, _events, changeView,_selectedDate);
    } else if (view == View.DAY) {
      return DayView(_assignments, _courses, _events, changeView,_selectedDate);
    } else if (view == View.WEEK) {
      return WeekView( _assignments, _courses, _events, changeView, _selectedDate);
    } else if (view == View.MONTH) {
      return MonthView(_assignments, _courses, _events, changeView,_selectedDate);
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
      _selectedDate = newDate;
      //simulates Assignment api call;
      Random r = new Random();
      for (int i = 0; i < 55; i++) {
        var rDate = new DateTime.utc(DateTime.now().year, DateTime.now().month,30, r.nextInt(24),r.nextInt(60));
        var assignment = new Assignment(id: i, name: "Assignment ${i.toString()}" , description: "Eh you could probably skip this", pp: 25, dueAt: rDate, hasSubmitted: false);
        _assignments.add(assignment);
      }
      for (var i = 0; i < 94; i++) {
        var rDate = new DateTime.utc(DateTime.now().year, DateTime.now().month,r.nextInt(30)+1, r.nextInt(24),r.nextInt(60));
        var event = new CustomEvent(mongoId: i.toString(),title: "Event $i", description: "Sicc Event",userId: 1,startTime: rDate,endTime: rDate.add(Duration(hours: 1)));
        _events.add(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    changeView(_currentViewType, _selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ViewManager(changeView, _selectedDate, _currentViewType),
            getView(_currentViewType, changeView),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () => showNotification(),
        tooltip: 'Show New Notification',
        child: Icon(Icons.add),
      ),
    );
  }

  Future showNotification() async {
    var android = AndroidNotificationDetails('id', 'name', 'description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await _localNotification.show(0, 'New Assignment', 'Neumont Planner Notification', platform);
  }
}
