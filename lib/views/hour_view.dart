import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/hour.dart';
import 'package:neumont_planner/models/objects.dart';

class HourView extends StatefulWidget {
  @override
  _HourViewState createState() => _HourViewState();
}

class _HourViewState extends State<HourView> {

  List<Assignment> assignments = [];
  List<String> hourList = [];

  @override
  Widget build(BuildContext context) {

    for (var i = 0; i < 24; i++) {
      hourList.add(i.toString());   
    }

    for (int i = 0; i <  5 ;i++) {
      assignments.add(new Assignment(i,"Assignment $i" ,"Description",55,DateTime.now(),false));
    }

  return Expanded(
    child: ListView(
      shrinkWrap: true,
      children: hourList.map((hour) => Card(
        child: Column(
          children: <Widget>[
            Hour(hour, assignments),
          ],
        ),
        )).toList()
      )
    );
  }
}