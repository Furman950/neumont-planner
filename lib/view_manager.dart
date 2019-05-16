import 'package:flutter/material.dart';
import 'package:neumont_planner/main.dart';

class ViewManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ViewManagerState();
  }  
}

class _ViewManagerState extends State<ViewManager>{

  View _currentView = View.MONTH;

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RaisedButton(child: new Text('Month'), onPressed: () {changeView (View.MONTH);}),
        new RaisedButton(child: new Text('Week'), onPressed: () {changeView( View.WEEK);}),
        new RaisedButton(child: new Text('Day'), onPressed: () { changeView(View.DAY);})
    ],);
  }

  void changeView(View newView){
    _currentView = newView;
    print(_currentView);
      }
}