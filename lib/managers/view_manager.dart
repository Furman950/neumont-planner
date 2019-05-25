import 'package:flutter/material.dart';
import 'package:neumont_planner/main.dart';

class ViewManager extends StatelessWidget {
  final void Function(View, DateTime) changeView;
  final DateTime selectedDate;
  final View currentView;

  ViewManager(this.changeView, this.selectedDate, this.currentView);

  Widget getText() {
    switch (currentView) {
      case View.DAY:
        return Padding(
          child: Text(
              selectedDate.month.toString() +
                  "/" +
                  selectedDate.day.toString() +
                  "/" +
                  selectedDate.year.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        );
      case View.HOUR:
        return Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              selectedDate.month.toString() +
                  "/" +
                  selectedDate.day.toString() +
                  "/" +
                  selectedDate.year.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ));
      case View.MONTH:
        return Padding(
          child: Text(
            selectedDate.month.toString() + "/" + selectedDate.year.toString(),
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        );
      case View.WEEK:
        DateTime viewingWeek =
            selectedDate.subtract(new Duration(days: selectedDate.weekday));
        return Padding(
          child: Text(
            "${viewingWeek.month}/${viewingWeek.day}/${viewingWeek.year} - ${viewingWeek.month}/${viewingWeek.day + 6}/${viewingWeek.year}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        );
      default:
        return Text("Yikes");
    }
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[getText()],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
                child: new Text('Month'),
                onPressed: () => changeView(View.MONTH, selectedDate)),
            new RaisedButton(
                child: new Text('Week'),
                onPressed: () => changeView(View.WEEK, selectedDate)),
            new RaisedButton(
                child: new Text('Day'),
                onPressed: () => changeView(View.DAY, selectedDate))
          ],
        )
      ],
    );
  }
}
