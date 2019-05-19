import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeekView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  List<String> weekViewStuff = [];
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 7; i++) {
      weekViewStuff.add((i+1).toString());
    }
    return Expanded(
        child: ListView(
            children: weekViewStuff
                .map((index) => Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[Text(index)],
                      ),
                    ))
                .toList()));
  }
}
