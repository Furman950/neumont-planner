import 'package:flutter/material.dart';
import 'package:neumont_planner/models/cards/assignment_card.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/custom_event.dart';

import 'abstract_view.dart';



class DayView extends AbstractView{

  DayView(List<Assignment> assignments, List<Course> courses, List<CustomEvent> events, changeView) : super(assignments, courses, events, changeView);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: assignments.map((index) => Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[new AssignmentCard(index, false, true, true, true, false, false, false, true, true, false)],
            ),
          )
          ).toList()
      )
    );
  }
}
