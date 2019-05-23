import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects.dart';
import 'package:neumont_planner/views/abstract_view.dart';

import '../main.dart';

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
            onPressed: () => changeView(View.DAY, day)
          ),
        ),
      );

      for(int j = 0; j < assignments.length; j++){
        if (assignments[j].dueAt.day == day.day && assignments[j].dueAt.month == day.month) {
          monthEvent.add(
            new Container(
              child: new Card(
                color: color,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    new Text('${day.month}/${day.day} - ${assignments[j].title}')
                  ]
                )
              )
            )
          );
        }
      }

      for(int j = 0; j < events.length; j++){
        if (events[j].startTime.day == day.day && events[j].startTime.month == day.month) {
          monthEvent.add(
            new Container(
              child: new Card(
                color: color,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    new Text('${day.month}/${day.day} - ${events[j].title}')
                  ]
                )
              )
            )
          );
        }
      }
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
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              children: monthView
            ),
          ),
          new Container(
            height: 145,
            child: new ListView(
              padding: const EdgeInsets.all(7),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: monthEvent,
            )
          )
        ]
      )
    );
  }
}