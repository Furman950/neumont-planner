import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/dateTimeFilter.dart';
import 'package:neumont_planner/helper/dateTime_Strings.dart';
import 'package:neumont_planner/models/objects/objects.dart';

class SummaryView extends StatelessWidget {
  final List<GuiObject> all;

  SummaryView(this.all);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
        child: ListView(
          children: all.map((obj) => Card(
            color: Colors.pink,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 3, 10, 5),
            child: Text("${obj.title}: ${parseDescription(obj.description, 100)}",style: TextStyle(color: Colors.white)),
            )
          )).toList()
        ),
      )
    );
  }
}
