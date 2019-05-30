import 'package:flutter/material.dart';
import 'package:neumont_planner/models/cards/assignment_card.dart';
import 'package:neumont_planner/models/cards/custom_event_card.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/objects.dart';

class WeekDateHelper extends StatelessWidget {
  final List<Assignment> assignmentList;
  final List<Event> eventLists;
  // final List<Course> courseLists;
  final String timeString;
  WeekDateHelper(this.assignmentList, this.eventLists, this.timeString);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(timeString),
        Column(
          children: <Widget>[Text(buildChildren(assignmentList, eventLists))],
          // children: <Widget>[
          //   Text(buildDisplayString(assignmentList, eventLists))
          // ])
        )
      ],
    );
  }

  String buildChildren(List<Assignment> assignments, List<Event> events) {
    String toReturn = "";

    if (assignments.length > 4) {
      toReturn += "${assignments.length} assignments\n";
    } else {
      List<AssignmentCard> list = assignments
          .map((a) => new AssignmentCard(a, false, true, true, false, false,
              false, false, true, true, false))
          .toList();

      for (AssignmentCard item in list) {
        toReturn += "${item.toString()}\n";
      }
    }
    toReturn += "${events.length} events";
    return toReturn;
  }
}
