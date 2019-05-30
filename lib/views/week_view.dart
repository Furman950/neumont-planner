import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/week_date_helper.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/objects.dart';
import 'package:neumont_planner/views/summary_view.dart';

import '../main.dart';
import 'abstract_view.dart';

class WeekView extends AbstractView {
  final DateTime date;

  WeekView(List<Assignment> assignments, List<Course> courses,
      List<Event> events, changeView, this.date)
      : super(assignments, courses, events, changeView);

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    List<String> dates = [];

    DateTime _firstOfWeek =
        currentDate.subtract(new Duration(days: currentDate.weekday));

    // print(_firstOfWeek);

    DateTime fromFirstOfWeek = _firstOfWeek;

    for (var i = 0; i < 7; i++) {
      DateTime temp = fromFirstOfWeek.add(new Duration(days: i));
      dates.add(
          "${describeEnum(_WeekDay.values[temp.weekday - 1])}, ${temp.month}/${temp.day}");
    }

    List<Container> cardList = buildCards(dates, assignments, events);

    double start = 0;
    double update = 0;

    return Expanded(
      child: new GestureDetector(
        child: Column(children: <Widget>[
          Container(
            height: 370,
             child:ListView(
              children: cardList)
            ),
            Text("Summary"),
            SummaryView(getMasterList())
        ],),
        onTap: () {
          changeView(View.DAY, currentDate);
        },
        onPanStart: (DragStartDetails details) {
          start = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          update = details.globalPosition.dx - start;
        },
        onPanEnd: (DragEndDetails details) {
          if (update - start > 0) {
            DateTime toPass = currentDate.subtract(new Duration(days: 7));
            changeView(View.WEEK, toPass);
          } else {
            DateTime toPass = currentDate.add(new Duration(days: 7));
            changeView(View.WEEK, toPass);
          }
        },
      ),
    );
  }
}

enum _WeekDay {
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURESDAY,
  FRIDAY,
  SATURDAY,
  SUNDAY
}

List<Container> buildCards(
    List<String> dates, List<Assignment> assignments, List<Event> events) {
  List<Container> toReturn = new List<Container>();
  for (String item in dates) {
    toReturn.add(new Container(
        child: Card(
      child:
          Column(children: <Widget>[WeekDateHelper(assignments, events, item),]),
    )));
  }
  return toReturn;
}
