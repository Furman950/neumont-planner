import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/change_date_helper.dart';
import 'package:neumont_planner/helper/dateTimeFilter.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/views/summary_view.dart';

import '../main.dart';
import 'abstract_view.dart';

class MonthView extends AbstractView {
  MonthView(List<Assignment> assignments, List<Course> courses,
      List<CustomEvent> events, changeView, DateTime selected)
      : super(assignments, courses, events, changeView, selected);

  @override
  Widget build(BuildContext context) {
    double start = 0;
    double update = 0;

    List<Container> monthView = [];
    DateTime firstDayOfMonth =
        new DateTime(selectedDate.year, selectedDate.month, 1);
    int offset = 0;

    if (monthView.isEmpty) {
      switch (firstDayOfMonth.weekday) {
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
      DateTime day = new DateTime(selectedDate.year, selectedDate.month, i);
      Color color = Colors.grey.withOpacity(0);

      if (day.month == selectedDate.month) {
        color = Colors.yellow.withOpacity(1);
      }

      if (day.day == DateTime.now().day &&
          day.month == DateTime.now().month &&
          day.year == DateTime.now().year) {
        color = Colors.orange.withOpacity(1);
      }

      monthView.add(
        new Container(
          width: 100,
          height: 100,
          child: new RaisedButton(
              color: color,
              child: new Text('${day.day}'),
              onPressed: () => changeView(View.WEEK, day)),
        ),
      );
    }

    return Expanded(
      child: GestureDetector(
        child: new Column(children: <Widget>[
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              children: monthView,
            ),
          ),
          Text("Summary"),
          SummaryView(getObjectsByMonth(selectedDate, getMasterList()))
        ]),
        onPanStart: (DragStartDetails details) {
          start = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          update = details.globalPosition.dx - start;
        },
        onPanEnd: (DragEndDetails details) {
          if (update > start) {
            changeView(View.MONTH, ChangeMonth().change(selectedDate, -1));
          } else {
            changeView(View.MONTH, ChangeMonth().change(selectedDate, 1));
          }
        },
      ),
    );
  }
}
