import 'package:flutter/material.dart';
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/objects.dart';

class  Hour extends StatelessWidget {

  Hour(this.hour, this.assignmentList);
  final List<Assignment> assignmentList;
  final  String hour;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Column(
        children: <Widget>[
          Text(hour),
          ListView(
            children: assignmentList.map((assignment) =>
              AssignmentCardRow(assignment, false, true, true, true, false, false)
            ).toList()
            )
          ],
      )
    );
  }
}