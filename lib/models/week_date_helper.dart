import 'package:flutter/cupertino.dart';
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/custom_event.dart';

import 'objects.dart';

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
        ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Text(buildDisplayString(assignmentList, eventLists))
            ]
            //     assignmentList.length < 4
            //         ? assignmentList
            //             .map((assignment) => AssignmentCardRow(
            //                 assignment, false, true, true, true, false, false))
            //             .toList()
            //         : <Widget>[
            //             Text("${assignmentList.length.toString()} assignments")
            //           ]),
            // // assignmentList
            // //     .map((assignment) => AssignmentCardColumn(
            // //         assignment, false, true, true, true, false, false))
            // //     .toList()),
            // ListView(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     children: eventLists
            //         .map((events) => EventCartListColumn(events))
            //         .toList())
            )
      ],
    );
  }

  String buildDisplayString(List<Assignment> assignments, List<Event> events) {
    String eventStr = "Total Events: ${events.length}";
    String assignmentStr = "";
    if (assignments.length < 3) {
      for (var i = 0; i < assignments.length; i++) {
        if (i == 2) {
          assignmentStr += assignments[i].title.toString();
        }
        assignmentStr += assignments[i].title.toString() + "\n";
      }
    } else {
      assignmentStr += "${assignments.length.toString()} assignments";
    }
    return "$assignmentStr$eventStr";
  }
}
