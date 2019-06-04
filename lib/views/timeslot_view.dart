import 'package:flutter/material.dart';
import 'package:neumont_planner/main.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'dart:async';

import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/service/raspberry_pi_api.dart';

class TimeSlotView extends StatefulWidget {
  final List<Assignment> _assignments;
  final int _assignmentID;
  TimeSlotView(this._assignments, [this._assignmentID = -1]);
  @override
  State<StatefulWidget> createState() =>
      _ViewState(this._assignments, this._assignmentID);
}

class _ViewState extends State<TimeSlotView> {
  RaspberryPiAPI api = new RaspberryPiAPI();

  int assignmentID;
  List<Assignment> _assignments;
  _ViewState(this._assignments, this.assignmentID);

  List<DropdownMenuItem<Assignment>> _dropDownMenuItems;
  Assignment _currentSelection;

  DateTime _dateTime = new DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  List<CustomEvent> events = new List<CustomEvent>();
  DateTime start;
  DateTime end;

  // List<DateTime> getDates() {
  //   do {

  //   } while ();
  // }

  Future<Null> _selectDate(BuildContext context, Assignment assignment) async {
    DateTime _temp = DateTime.now();
    // print("FirstDate: $_temp");
    // print("Due Date:  ${_assignment.dueAt}");
    final DateTime toReturn = await showDatePicker(
        context: context,
        initialDate: _temp,
        firstDate: _temp,
        lastDate: assignment.dueAt);

    if (toReturn != null) {
      setState(() {
        _dateTime = toReturn;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay _time = TimeOfDay.now();

    final TimeOfDay toReturn =
        await showTimePicker(context: context, initialTime: _time);

    if (toReturn != null) {
      setState(() {
        _timeOfDay = toReturn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _dropDownMenuItems = sortAssignments();
    // _currentSelection = getStartingAssignment(
    //     assignmentID == -1 ? _assignments[0].id : assignmentID);
    _currentSelection = _dropDownMenuItems[0].value;

    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Column(children: <Widget>[
          DropdownButton<Assignment>(
            value: _currentSelection,
            items: _dropDownMenuItems,
            onChanged: changeDropDownItem,
          ),
          new RaisedButton(
            onPressed: () => Navigator.pop(context),
          )
        ])));
  }

  List<DropdownMenuItem<Assignment>> sortAssignments() {
    List<DropdownMenuItem<Assignment>> toReturn =
        new List<DropdownMenuItem<Assignment>>();
    DateTime dateTime = DateTime.now();

    for (var item in _assignments) {
      if (dateTime.isBefore(item.dueAt)) {
        toReturn.add(new DropdownMenuItem(
          value: item,
          child: new Text(item.title),
        ));
      }
    }
    return toReturn;
  }

  void changeDropDownItem(Assignment currentSelection) {
    // print("$currentSelection");

    _selectTime(context);
    _selectDate(context, currentSelection);

    start = new DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
        _timeOfDay.hour, _timeOfDay.minute);
    end = start.add(new Duration(hours: 1));

    CustomEvent newEvent = new CustomEvent(
        description: currentSelection.description,
        title: currentSelection.title,
        startTime: start,
        endTime: end);
    print("New Event StartTime: ${newEvent.startTime}");
    print("New Event EndTime: ${newEvent.endTime}");
    api.createEvent(newEvent,
        "1~rFQEBXNCJVGuQYLTODQZUvihtzQWQt6aO3IOyOBS85d4p9UJ10lC7A5qe6ySG7eV");
    setState(() {
      _currentSelection = currentSelection;
    });
  }

  Assignment getStartingAssignment(int assignmentID) {
    if (assignmentID == -1) {
      return _assignments[0];
    }
    return _assignments.singleWhere((x) => x.id == assignmentID);
  }
}
