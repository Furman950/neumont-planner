import 'package:flutter/material.dart';
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/course.dart';
import 'package:neumont_planner/models/hour.dart';
import 'package:neumont_planner/models/objects.dart';
import 'package:neumont_planner/views/abstract_view.dart';

class HourView extends AbstractView{
  
  HourView(List<Assignment> assignments, List<Course> courses, List<Event> events, changeView) : super(assignments, courses, events, changeView);

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