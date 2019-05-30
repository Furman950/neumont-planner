import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/dateTimeFilter.dart';
import 'package:neumont_planner/helper/week_date_helper.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/views/summary_view.dart';

import '../main.dart';
import 'abstract_view.dart';

class WeekView extends AbstractView {

  WeekView(List<Assignment> assignments, List<Course> courses,List<CustomEvent> events, changeView, DateTime selected): super(assignments, courses, events, changeView,selected);

  @override
  Widget build(BuildContext context) {
    List<String> dateStrings = [];
    List<DateTime> dates = [];

    DateTime _firstOfWeek =selectedDate.subtract(new Duration(days: selectedDate.weekday));

    DateTime fromFirstOfWeek = _firstOfWeek;

    for (var i = 0; i < 7; i++) {
      DateTime temp = fromFirstOfWeek.add(new Duration(days: i));
      dates.add(temp);
      dateStrings.add("${describeEnum(_WeekDay.values[temp.weekday - 1])}, ${temp.month}/${temp.day}");
    }

    double start = 0;
    double update = 0;

    return Expanded(
      child: new GestureDetector(
        child: Column(children: <Widget>[
          Container(
            height: 370,
             child:ListView(
              children:  buildCards(dateStrings, dates,assignments, events))
            ),
            Text("Summary"),
            SummaryView(getObjectsByWeek(selectedDate, getMasterList()))
        ],),
        onTap: () {
          changeView(View.DAY, selectedDate);
        },
        onPanStart: (DragStartDetails details) {
          start = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          update = details.globalPosition.dx - start;
        },
        onPanEnd: (DragEndDetails details) {
          if (update - start > 0) {
            DateTime toPass = selectedDate.subtract(new Duration(days: 7));
            changeView(View.WEEK, toPass);
          } else {
            DateTime toPass = selectedDate.add(new Duration(days: 7));
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

List<Container> buildCards(List<String> dateStrings, List<DateTime> dates , List<Assignment> assignments, List<CustomEvent> events) {
  List<Container> toReturn = new List<Container>();
  for (String item in dateStrings) {
    toReturn.add(new Container(
        child: Card(
          child: Column(
            children: <Widget>[WeekDateHelper(assignments, events, item),]),
    )));
  }
  return toReturn;
}
