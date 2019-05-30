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
        DateTime startOfWeek = selectedDate.subtract(new Duration(days: selectedDate.weekday));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
        return Padding(
          child: Text(
            "${startOfWeek.month}/${startOfWeek.day}/${startOfWeek.year} - ${endOfWeek.month}/${endOfWeek.day }/${endOfWeek.year}",
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
