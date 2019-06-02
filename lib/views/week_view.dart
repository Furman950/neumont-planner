import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/dateTimeFilter.dart';
import 'package:neumont_planner/models/cards/assignment_card.dart';
import 'package:neumont_planner/models/cards/course_card.dart';
import 'package:neumont_planner/models/cards/custom_event_card.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/models/objects/objects.dart';
import 'package:neumont_planner/views/summary_view.dart';

import '../main.dart';
import 'abstract_view.dart';

class WeekView extends AbstractView {

  WeekView(List<Assignment> assignments, List<Course> courses,List<CustomEvent> events, changeView, DateTime selected): super(assignments, courses, events, changeView,selected);

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = [];

    DateTime _firstOfWeek =selectedDate.subtract(new Duration(days: selectedDate.weekday));

    DateTime fromFirstOfWeek = _firstOfWeek;

    for (var i = 0; i < 7; i++) {
      DateTime temp = fromFirstOfWeek.add(new Duration(days: i));
      dates.add(temp);
    }

    double start = 0;
    double update = 0;

    return Expanded(
      child: new GestureDetector(
        child: Column(children: <Widget>[
          Container(
            height: 370,
             child:ListView(
              children:  dates.map((date) =>
                Card(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text(getButtonDate(date)),
                        onPressed: () => changeView(View.DAY, date) ,
                      ),
                      Text(getAssignmentString(getObjectsByWeek(selectedDate,getSortedAssignments()))),
                      Text(getEventString(getObjectsByWeek(selectedDate,getSortedEvents()))),
                      Text(getCourseString(getObjectsByWeek(selectedDate, getSortedCourses()))),
                    ],
                  ),
                )
              ).toList())
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

  String getButtonDate(DateTime temp){
    return "${describeEnum(_WeekDay.values[temp.weekday - 1])}, ${temp.month}/${temp.day}";
  }

  String getAssignmentString(List<GuiObject> assignments) {
    String toReturn = "";
    if (assignments.length > 4) {
      toReturn += "${assignments.length} assignments\n";
    }else if(assignments.length <= 0){
      toReturn += "No Assignments Due";
    }  else {
      List<AssignmentCard> list = assignments.map((a) => 
        new AssignmentCard(a, false, true, true, false, false,false, false, true, true, false)
      ).toList();

      for (AssignmentCard item in list) {
        toReturn += "${item.toString()}\n";
      }
    }
    return toReturn;
  }

  String getEventString(List<GuiObject> events) {
    String toReturn = "";
    if (events.length > 4) {
      toReturn += "${events.length} events\n";
    } else if(courses.length <= 0){
      toReturn += "No Events";
    }else{  
      List<CustomEventCard> list = events.map((a) => 
        new CustomEventCard()
      ).toList();

      for (var item in list) {
        toReturn += "${item.toString()}\n";
      }
    }
    return toReturn;
  }

    String getCourseString(List<GuiObject> courses) {
    String toReturn = "";
    if (courses.length > 4) {
      toReturn += "${courses.length} classes\n";
    }else if(courses.length <= 0){
      toReturn += "No Courses";
    } else {
      List<CourseCard> list = courses.map((a) => 
        new CourseCard(a, false, false, true, true, true, false, true)
      ).toList();

      for (var item in list) {
        toReturn += "${item.toString()}\n";
      }
    }
    return toReturn;
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
