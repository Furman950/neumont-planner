import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects.dart';
import 'package:neumont_planner/models/week_date_helper.dart';
import 'package:neumont_planner/views/abstract_view.dart';

import '../main.dart';

class WeekView extends AbstractView {
  final DateTime date;

  WeekView(List<Assignment> assignments, List<Course> courses,
      List<Event> events, changeView, this.date)
      : super(assignments, courses, events, changeView);

  @override
  Widget build(BuildContext context) {
    DateTime currentDate;
    List<String> dates = [];

    if (date == null) {
      currentDate = DateTime.now();
    } else {
      currentDate = date;
    }

    DateTime _firstOfWeek =
        currentDate.subtract(new Duration(days: currentDate.weekday));

    print(_firstOfWeek);

    DateTime fromFirstOfWeek = _firstOfWeek;

    // for (var i = 6, j = 0; j < 7; i++, j++) {
    //   // print("${describeEnum(_WeekDay.values[i])} ${_thisWeek.month}/${(_thisWeek.day+j)}");
    //   dates.add(
    //       "${describeEnum(_WeekDay.values[i])}, ${_firstOfWeek.month}/${(_firstOfWeek.day + j)}");
    //   if (i == 6) {
    //     i = -1;
    //   }
    // }

    for (var i = 0; i < 7; i++) {
      DateTime temp = fromFirstOfWeek.add(new Duration(days: i));
      // print(fromFirstOfWeek.add(new Duration(days: i)));
      // dates.add(
      //     "${describeEnum(_WeekDay.values[fromFirstOfWeek.weekday - 1])}, ${fromFirstOfWeek.month}/${fromFirstOfWeek.day}");
      dates.add(
          "${describeEnum(_WeekDay.values[temp.weekday - 1])}, ${temp.month}/${temp.day}");
    }

    List<Container> cardList = buildCards(dates, assignments, events);

    double start = 0;
    double update = 0;

    return Expanded(
      child: new GestureDetector(
        child: ListView(
          children: cardList,
        ),
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
            DateTime toPass = currentDate.subtract(new Duration(days: 7));
            print(toPass.toString());
            changeView(View.WEEK, toPass);
          } else {
            //next
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
      height: 100,
      child: Card(
        child: Column(
          children: assignments.length < 4
              ? <Widget>[WeekDateHelper(assignments, item)]
              : <Widget>[
                  Text("$item\n${assignments.length.toString()} assignments")
                ],
        ),
      ),
    ));
  }
  return toReturn;
}
