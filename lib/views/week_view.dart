import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects.dart';
import 'package:neumont_planner/models/week_date_helper.dart';
import 'package:neumont_planner/views/abstract_view.dart';

import '../main.dart';

class WeekView extends AbstractView {

  final DateTime date;

  WeekView(List<Assignment> assignments, List<Course> courses, List<Event> events, changeView,this.date) : super(assignments, courses, events, changeView);

  @override
  Widget build(BuildContext context) {
    DateTime currentDate;
    List<String> dates = [];
    if (date == null) {
      print("null");
      currentDate = DateTime.now();
    } else {
      print("notNull");
      currentDate = date;
    }
    DateTime _viewWeek =
        currentDate.subtract(new Duration(days: currentDate.weekday));

    for (var i = 6, j = 0; j < 7; i++, j++) {
      // print("${describeEnum(_WeekDay.values[i])} ${_thisWeek.month}/${(_thisWeek.day+j)}");
      dates.add(
          "${describeEnum(_WeekDay.values[i])}, ${_viewWeek.month}/${(_viewWeek.day + j)}");
      if (i == 6) {
        i = -1;
      }
    }
    double start = 0;
    double update = 0;
    // double end = 0;

    return Expanded(
        child: ListView(
            shrinkWrap: true,
            children: dates
                .map((dateString) => GestureDetector(
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
                        //previoius
                        print(currentDate.toString());
                        DateTime toPass =
                            currentDate.subtract(new Duration(days: 7));
                        print(toPass.toString());
                        changeView(View.WEEK, toPass);
                      } else {
                        //next
                        DateTime toPass =
                            currentDate.add(new Duration(days: 7));
                        changeView(View.WEEK, toPass);
                      }
                    },
                    child: Container(
                        height: 100,
                        child: Card(
                          child: Column(
                            children: assignments.length < 4
                                ? <Widget>[
                                    WeekDateHelper(assignments, dateString)
                                  ]
                                : <Widget>[
                                    Text(
                                        "$dateString\n${assignments.length.toString()} assignments")
                                  ],
                          ),
                        ))))
                .toList()));
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

class CardBuilder {
  List<Card> cards() {
    return null;
  }
}
