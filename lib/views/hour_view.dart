import 'package:flutter/material.dart';
import 'package:neumont_planner/models/hour.dart';
import 'package:neumont_planner/models/objects.dart';

import '../main.dart';

class HourView extends StatelessWidget {

  final List<Assignment> assignments;
  final List<Course> courses;
  final List<Event> events ;
  final void Function(View) changeView;

  HourView( this.assignments, this.courses, this.events, this.changeView);

  @override
  Widget build(BuildContext context) {
    List<String> hourList = [];
    for (var i = 0; i < 24; i++) {
      hourList.add(i.toString());   
    }
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: hourList.map((hour) => Card(
          child: Column(
            children: <Widget>[
              Hour(hour, assignments)
            ],
            )
          )
        ).toList()
      )
    );
  }
}