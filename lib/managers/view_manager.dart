import 'package:flutter/material.dart';
import 'package:neumont_planner/main.dart';

class ViewManager extends StatelessWidget{

  final void Function(View,DateTime) changeView;
  final DateTime selectedDate;
  ViewManager(this.changeView,this.selectedDate);

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RaisedButton(child: new Text('Month'), onPressed: () => changeView(View.MONTH, selectedDate)),
        new RaisedButton(child: new Text('Week'), onPressed: () => changeView(View.WEEK, selectedDate)),
        new RaisedButton(child: new Text('Day'), onPressed: () => changeView(View.DAY, selectedDate))
      ],
    );
  }
}