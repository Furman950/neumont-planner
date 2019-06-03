import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/change_date_helper.dart';
import 'package:neumont_planner/main.dart';

class ViewManager extends StatelessWidget {
  final TimeChanger changer;
  final void Function(View, DateTime) changeView;
  final DateTime selectedDate;
  final View currentView;

  ViewManager(this.changeView,this.selectedDate,this.currentView,this.changer);

  Widget getText() {
    switch (currentView) {
      case View.DAY:
          return Text(
              selectedDate.month.toString() +
                  "/" +
                  selectedDate.day.toString() +
                  "/" +
                  selectedDate.year.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
        );
      case View.HOUR:
            return Text(
              selectedDate.month.toString() +
                  "/" +
                  selectedDate.day.toString() +
                  "/" +
                  selectedDate.year.toString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            );
      case View.MONTH:
            return Text(
            selectedDate.month.toString() + "/" + selectedDate.year.toString(),
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        );
      case View.WEEK:
        DateTime startOfWeek = selectedDate.subtract(new Duration(days: selectedDate.weekday));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
        return Text(
            "${startOfWeek.month}/${startOfWeek.day}/${startOfWeek.year} - ${endOfWeek.month}/${endOfWeek.day }/${endOfWeek.year}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(icon: Icon(Icons.navigate_before),onPressed: () => changeView(currentView, changer.change(selectedDate, -1))),
            getText(),
            IconButton(icon: Icon(Icons.navigate_next), onPressed: () => changeView(currentView, changer.change(selectedDate,  1)))],
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
