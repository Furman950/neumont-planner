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
                    children: buildWidgetsForWeek(date),
                  ),
                )
              ).toList())
            ),
            Text("Summary"),
            SummaryView(getObjectsByWeek(selectedDate, getMasterList()))
        ],),
        onPanStart: (DragStartDetails details) {
          start = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          update = details.globalPosition.dx - start;
        },
        onPanEnd: (DragEndDetails details) {
          if (update >  start) {
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

  List <Widget> buildAssignmentCards(List<GuiObject> assignments) {
    List <Widget> toReturn= [];
    if (assignments.length > 4) {
      toReturn.add(Text("${assignments.length} Due"));
    }else if(assignments.length <= 0){
     toReturn.add(Text("No Assignments Due"));
    }  else {
       assignments.forEach((a) =>{
        toReturn.add( new AssignmentCard(a, false, true, true, false, false,false, false, true, true, false))
       });
    }
    return toReturn;
  }

  List <Widget>  buildEventCards(List<GuiObject> events) {
    List <Widget> toReturn= [];
    if (events.length > 4) {
      toReturn.add(Text("${events.length} events"));
    } else if(courses.length <= 0){
      toReturn.add(Text("No Events"));
    }else{  
      events.forEach((a) => 
        toReturn.add(new CustomEventCard())
      );
    }
    return toReturn;
  }

    List <Widget>  buildCourseCards(List<GuiObject> courses) {
    List <Widget> toReturn= [];
    if (courses.length > 4) {
      toReturn.add(Text( "${courses.length} classes"));
    }else if(courses.length <= 0){
     toReturn.add(Text("No Courses"));
    } else {
      courses.forEach((a) => 
        toReturn.add(new CourseCard(a, false, false, true, true, true, false, true))
      );
    }
    return toReturn;
    }

  buildWidgetsForWeek(DateTime date) {
    List <Widget> toBeReturned = [];
    toBeReturned.add(RaisedButton(
      child: Text(getButtonDate(date)),
      onPressed: () => changeView(View.DAY, date) ,
    ));

    buildAssignmentCards(getObjectsByDay(date,getSortedAssignments())).forEach((f)=>
      toBeReturned.add(f)
    );
    buildEventCards(getObjectsByDay(date,getSortedEvents())).forEach((f)=>
      toBeReturned.add(f)
    );
    buildCourseCards(getObjectsByDay(date, getSortedCourses())).forEach((f)=>
      toBeReturned.add(f)
    );
    return toBeReturned;
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
