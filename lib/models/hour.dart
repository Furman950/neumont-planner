import 'package:flutter/material.dart';
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/assignment_card.dart';

class  Hour extends StatelessWidget {

  Hour(this.hour, this.assignmentList);
  final List<Assignment> assignmentList;
  final  String hour;

  @override
  Widget build(BuildContext context) {

      return Column(
        children: <Widget>[
          Text(hour),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: assignmentList.map( (assignment) =>
              AssignmentCardRow(assignment, false, true, true, true, false, false),
            ).toList()
            )
          ],
    );
  }
}