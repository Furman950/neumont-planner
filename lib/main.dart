import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/service/abstractServices/canvas_service.dart';
import 'package:neumont_planner/service/canvas_api.dart';
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

CanvasService canvasService = new CanvasAPI();

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
  Timer _timer;
  int _assignmentCount;
  View _currentViewType = View.MONTH;
  DateTime _today = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  List<Assignment> _assignments = [];
  List<Course> _courses = [];
  List<CustomEvent> _events = [];

  @override
  void initState() {
    super.initState();
    _fetchAssignments();
    _timer = Timer.periodic(Duration(seconds: 60), (Timer t) => showNotification());
    _localNotification = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    _localNotification.initialize(initSettings);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _fetchAssignments() {
    print("Fetching assignments");
    var assignmentFuture = canvasService.getAssignments(null, null,
        "1~WS9hfD2EzLPp7ULFQRFdprbo8GpYCbwuqtLh9oqXifrvb23wg8vWzuqWpT091bzM");
    assignmentFuture.then((list) => {
      print("Settings list: " + list.length.toString()),
        list.forEach((a) => _assignments.add(a))
    });
    _assignmentCount = _assignments.length;
  }

  int _fetchAssignmentsCount() {
    int output = 0;
    var assignmentList = canvasService.getAssignments(null, null,
        "1~WS9hfD2EzLPp7ULFQRFdprbo8GpYCbwuqtLh9oqXifrvb23wg8vWzuqWpT091bzM");
    assignmentList.then((list) => {
      output = list.length,
    });    
    return output;
  }

  Widget getView(View view, Function(View, DateTime) changeView) {
    if (view == View.DAY && _selectedDate.day == _today.day) {
      return HourView(
          _assignments, _courses, _events, changeView, _selectedDate);
    } else if (view == View.DAY) {
      return DayView(
          _assignments, _courses, _events, changeView, _selectedDate);
    } else if (view == View.WEEK) {
      return WeekView(
          _assignments, _courses, _events, changeView, _selectedDate);
    } else if (view == View.MONTH) {
      return MonthView(
          _assignments, _courses, _events, changeView, _selectedDate);
    } else {
      return Text('Yikes');
    }
  }

  void changeView(View view, DateTime newDate) {
    setState(() {
      _currentViewType = view;
      _selectedDate = newDate;
      _assignmentCount = _assignments.length;
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
        onPressed: () => null,
        tooltip: 'Show New Notification',
        child: Icon(Icons.add),
      ),
    );
  }

  Future showNotification() async {
    var android = AndroidNotificationDetails('id', 'name', 'description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    if (_assignmentCount < _fetchAssignmentsCount()) {
      await _localNotification.show(0, 'New Assignment', 'Neumont Planner Notification', platform);
    }
  }
}
