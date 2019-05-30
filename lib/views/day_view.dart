import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/dateTimeFilter.dart';
import 'package:neumont_planner/models/cards/assignment_card.dart';
import 'package:neumont_planner/models/cards/course_card.dart';
import 'package:neumont_planner/models/cards/custom_event_card.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/models/objects/objects.dart';

import 'abstract_view.dart';

class DayView extends AbstractView{

  DayView(List<Assignment> assignments, List<Course> courses, List<CustomEvent> events, changeView,DateTime selected) : super(assignments, courses, events, changeView,selected);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: buildWidgetListForDay(getObjectsByDay(selectedDate, getMasterList())),
      )
    );
  }

    List<Widget> buildWidgetListForDay(List<GuiObject> objs ){
    List<Widget> toBeReturned = [];

    if(objs.length == 0){
       toBeReturned.add(Text("Nothing To Do"));
    }

    for (var obj in objs) {
      if(obj is Assignment){
        toBeReturned.add(AssignmentCard(obj, false, true, true, true, false, false, false, true, true, false));
      }else if (obj is CustomEvent) {
        toBeReturned.add(CustomEventCard());
      }else if(obj is Course){
        toBeReturned.add(CourseCard(obj, false, true, false, true, false, false, true));
      }
    }
    return toBeReturned;
  }          
}
