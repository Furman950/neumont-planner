import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects.dart';
import 'package:neumont_planner/views/abstract_view.dart';

class MonthView extends AbstractView {

  MonthView(List<Assignment> assignments, List<Course> courses, List<Event> events, changeView) : super(assignments, courses, events, changeView);

  @override
  Widget build(BuildContext context) {
  List<Container> monthView = [];
  List<Container> monthEvent = [];
    DateTime today = DateTime.now();
    DateTime firstDayOfMonth = new DateTime(today.year, today.month, 1);
    int offset = 0;

    if(monthView.isEmpty){
      switch(firstDayOfMonth.weekday) {
        case DateTime.sunday:
          offset = 1;
          break;
        case DateTime.monday:
          offset = 0;
          break;
        case DateTime.tuesday:
          offset = -1;
          break;
        case DateTime.wednesday:
          offset = -2;
          break;
        case DateTime.thursday:
          offset = -3;
          break;
        case DateTime.friday:
          offset = -4;
          break;
        case DateTime.saturday:
          offset = -5;
          break;
      }
    }

    for (int i = offset; monthView.length < 42; i++) {
      DateTime day = new DateTime(today.year, today.month, i);
      Color color = Colors.grey;

      if (day.month == today.month){
        color = Colors.yellow;
      }
      else {
        color = Colors.grey;
      }

      if (day.day == today.day && day.month == today.month && day.year == today.year){
        color = Colors.orange;
      }

      monthView.add(
        new Container(
          width: 100,
          height: 100,
          child: new RaisedButton(
            color: color,
            child: new Text('${day.day}'),
            //onPressed: () => new DayView(day),
            onPressed: () => print('${day.toString()}'),
          ),
        ),
      );

      monthEvent.add(
        new Container(
          height: 50,
          child: new Card(
            color: color,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                new Text('Event on ${day.month}/${day.day}')
              ]
            )
          )
        )
      );
    }

    return Expanded(
      child: new Column(
        children: <Widget> [
          new Container(
            width: 700,
            height: 355,
            child: GridView.count(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: monthView
            ),
          ),
          new Container(
            height: 150,
            child: new ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: monthEvent
            )
          )
        ]
      )
    );
  }
}