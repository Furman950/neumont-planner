import 'package:flutter/material.dart';
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
          children: all.map((obj) => Padding(
            padding: EdgeInsets.fromLTRB(0, 2, 0, 5),
            child: Text("${obj.title}: ${obj.description.length<= 100?obj.description:obj.description.substring(0,100)}"),
          )).toList()
        ),
      )
    );
  }
}