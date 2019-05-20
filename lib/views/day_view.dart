import 'package:flutter/material.dart';
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/objects.dart';

class DayView extends StatefulWidget {
  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {

  List<Assignment> assignments = []; 
  @override
  Widget build(BuildContext context) {
    for (int i = 1; i < 100; i++) {
      assignments.add(new Assignment(i,"Assignment $i","Description",55,DateTime.now(),false));
    }

    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: assignments.map((index) => Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[new AssignmentCardRow(index,false,true,false,false,false,false)],
            ),
          )
          ).toList()
      )
    );
  }
}
