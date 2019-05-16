import 'package:flutter/material.dart';

class DayView extends StatefulWidget {
  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {

List<String> stuff = [];
  @override
  Widget build(BuildContext context) {

    for (int i = 1; i < 100; i++) {
      stuff.add(i.toString());
    }

    return Expanded(
      child: ListView(
      children: stuff.map((index) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text(index)
        ],),
      )
      ).toList()
    )
    );
  }
}