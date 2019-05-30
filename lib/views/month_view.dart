import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/objects.dart';
import 'package:neumont_planner/views/summary_view.dart';


import '../main.dart';
import 'abstract_view.dart';

class MonthView extends AbstractView {

  MonthView(List<Assignment> assignments, List<Course> courses, List<Event> events, changeView) : super(assignments, courses, events, changeView);

  @override
  Widget build(BuildContext context) {
  List<Container> monthView = [];
    DateTime today = DateTime.now();
    DateTime firstDayOfMonth = new DateTime(today.year, today.month, 1);
    int offset = 0;

    if(monthView.isEmpty){
      switch(firstDayOfMonth.weekday) {
        case DateTime.sunday:
          offset = 1;
          break;
        case DateTime.monday:
          offset = 0;
          break;
        case DateTime.tuesday:
          offset = -1;
          break;
        case DateTime.wednesday:
          offset = -2;
          break;
        case DateTime.thursday:
          offset = -3;
          break;
        case DateTime.friday:
          offset = -4;
          break;
        case DateTime.saturday:
          offset = -5;
          break;
      }
    }

    for (int i = offset; monthView.length < 42; i++) {
      DateTime day = new DateTime(today.year, today.month, i);
      Color color = Colors.grey;

      if (day.month == today.month){
        color = Colors.yellow;
      }
      else {
        color = Colors.grey;
      }

      if (day.weekday == DateTime.saturday && day.month == today.month || day.weekday == DateTime.sunday && day.month == today.month) {
        color = Colors.red;
      }

      if (day.day == today.day && day.month == today.month && day.year == today.year){
        color = Colors.orange;
      }

      monthView.add(
        new Container(
          width: 100,
          height: 100,
          child: new RaisedButton(
            color: color,
            child: new Text('${day.day}'),
             onPressed: () => changeView(View.WEEK, day)
          ),
        ),
      );
    }

    return Expanded(
      child: new Column(
        children: <Widget> [
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Sun.'),
              new Text('        Mon.'),
              new Text('      Tues.'),
              new Text('       Wed.'),
              new Text('      Thur.'),
              new Text('         Fri.'),
              new Text('          Sat.'),
            ],
          ),
          new Container(
            width: 700,
            height: 355,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 7,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.fromLTRB(10,10,10,0),
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              children: monthView,
            ),
          ),
          Text("Summary"),
          SummaryView(getMasterList())
        ]
      )
    );
  }
}