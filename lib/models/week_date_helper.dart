import 'package:flutter/cupertino.dart';
import 'package:neumont_planner/models/assignment.dart';

import 'objects.dart';

class WeekDateHelper extends StatelessWidget {
  final List<Assignment> assignmentList;
  final String timeString;
  WeekDateHelper(this.assignmentList, this.timeString);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Text(timeString),
        ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: assignmentList
                .map((assignment) => AssignmentCardRow(
                    assignment, false, true, true, true, false, false))
                .toList())
      ],
    );
  }
}
