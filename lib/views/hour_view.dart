import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/timeObjects.dart';
import 'package:neumont_planner/models/cards/assignment_card.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/objects.dart';

import 'abstract_view.dart';


class HourView extends AbstractView {
  
  HourView(List<Assignment> assignments, List<Course> courses,List<Event> events, changeView): super(assignments, courses, events, changeView);

  @override
  Widget build(BuildContext context) {

    List<String> hourList = [];

    for (var i = 0; i < 24; i++) {
      hourList.add(i.toString());
    }
    return Expanded(
      child: Padding(
      padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(child: 
              ListView(
                children: hourList.map((hour) => Container(
                  child: Row(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child:Text(hour)
                      ,),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: getObjectsByHour(hour, assignments).map((assignment) => 
                            AssignmentCard(assignment, false, true, true, true, false, false, false, true, true, false)
                          ).toList()
                        )
                      )
                    ])
                  )).toList())
              ,)
            ],
          )
        )
    );
  }
}
