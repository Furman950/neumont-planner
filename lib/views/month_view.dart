import 'package:flutter/material.dart';

class MonthView extends StatefulWidget {
  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {

List<String> stuff = [];
  @override
  Widget build(BuildContext context) {

    for (int i = 1; i < 20; i++) {
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