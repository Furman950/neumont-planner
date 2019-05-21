import 'package:flutter/material.dart';
import 'package:neumont_planner/main.dart';

class ViewManager extends StatelessWidget{

  final void Function(View) changeView;
  ViewManager(this.changeView);

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RaisedButton(child: new Text('Month'), onPressed: () => changeView(View.MONTH)),
        new RaisedButton(child: new Text('Week'), onPressed: () => changeView(View.WEEK)),
        new RaisedButton(child: new Text('Day'), onPressed: () => changeView(View.DAY))
      ],
    );
  }
}