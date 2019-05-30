import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/dateTime_Strings.dart';
import 'package:neumont_planner/models/objects/assignment.dart';

class AssignmentCard extends StatelessWidget {

  final Assignment _assignment;
  final bool _showId;
  final bool _showName;
  final bool _showCourseId;
  final bool _showDescription;
  final bool _showPP;
  final bool _showDueAt;
  final bool _showAllowedAttempts;
  final bool _showHasSubmitted;
  final bool _showIsQuizAssignment;
  final bool _showGradingType;

  AssignmentCard(this._assignment, this._showId, this._showDescription, this._showDueAt, this._showPP, this._showGradingType, this._showAllowedAttempts, this._showCourseId, this._showName, this._showHasSubmitted, this._showIsQuizAssignment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(getTextOfAssignment())
      );
  }
    
  String getTextOfAssignment() {
    String s = "";
    if(_showId){
      s += "id: ${_assignment.id} ";
    }

    if(_showName){
      s += "${_assignment.name} ";
    }

    if(_showCourseId){
      s += "Course ${_assignment.courseId}";
    }

    if(_showDescription){
      s += "${_assignment.description} ";
    }

    if(_showPP){
      s += "| ${_assignment.pp}  points | ";
    }

    if(_showAllowedAttempts){
      s += "${_assignment.allowedAttempts} attempts";
    }

    if(_showHasSubmitted){
      s += _assignment.hasSubmitted? "Submitted": "Not Submitted";
    }

    if(_showIsQuizAssignment){
      s+= _assignment.isQuizAssignment? "Quiz ":"";
    }

    if(_showDueAt){
      var day = _assignment.dueAt.day;
      var month = _assignment.dueAt.month;

      s += " $month/$day @ ${getHourAndMinuteByTime(_assignment.dueAt)}";
    }

    if(_showGradingType){
      s+= "${_assignment.gradingType} type ";
    }
    return s;
  }
}