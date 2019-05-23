import 'package:flutter/material.dart';
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/objects.dart';

import '../main.dart';

class DayView extends StatelessWidget {

  final List<Assignment> assignments; 
  final List<Course> courses; 
  final List<Event> events; 
  final void Function(View,DateTime) changeView;

  DayView(this.assignments,this.courses,this.events,this.changeView);

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
