import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects.dart';

class AssignmentCard extends StatefulWidget {

AssignmentCard(this.assignment);

final Assignment assignment;

  @override
  _AssignmentCardState createState() => _AssignmentCardState(assignment);
}

class _AssignmentCardState extends State<AssignmentCard> {

  Assignment _assignment;
  _AssignmentCardState(this._assignment);

  @override
  Widget build(BuildContext context) {
    int id = _assignment.id;
    String description = _assignment.description;
    DateTime start = _assignment.dueAt;
    double pp =  _assignment.pp;
    bool hasSub = _assignment.hasSubmitted;

    
    return Row(
      children: <Widget>[
        Text('$id'),
        Text('$description'),
        Text('$start'),
        Text('$pp'),
        Text('$hasSub'),
      ],
    );
  }
}