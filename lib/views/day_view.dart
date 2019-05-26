import 'package:flutter/material.dart';
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/assignment_card.dart';
import 'package:neumont_planner/models/course.dart';
import 'package:neumont_planner/models/objects.dart';
import 'package:neumont_planner/views/abstract_view.dart';

class DayView extends AbstractView{

  DayView(List<Assignment> assignments, List<Course> courses, List<Event> events, changeView) : super(assignments, courses, events, changeView);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: assignments.map((index) => Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[new AssignmentCardRow(index,false,true,false,true,false,false)],
            ),
          )
          ).toList()
      )
    );
  }
}
