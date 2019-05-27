import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects.dart';

abstract class AssignmentCard extends StatelessWidget{

  AssignmentCard(this._assignment,this._showID,this._showTitle,this._showDescription,this._showPP,this._showDueDate,this._showHasSubmitted);
  final Assignment _assignment;
  final bool _showTitle;
  final bool _showDescription;
  final bool _showID;
  final bool _showPP;
  final bool _showDueDate;
  final bool _showHasSubmitted;

  Container getInfo() {
    String text = "";

    if(_showID){
      text += "Id: ${_assignment.id.toString()} ";
    }

      if(_showTitle){
      text += "${_assignment.title} ";
      }

      if(_showDescription){
      text += "${_assignment.description} ";
      }

      if(_showPP){
      text += "(${_assignment.pp} points) ";
      }

      if(_showDueDate){
        text += "Due: ${_assignment.dueAt.month}/${_assignment.dueAt.day}/${_assignment.dueAt.year} ";
      }

      if(_showHasSubmitted){
      return  Container(
        child: Text(
          text,
          ),
        color: _showHasSubmitted? Colors.green: Colors.red,
        );
      }else{
        return  Container(
        child: Text( text),
        );
      }
    }
}

class AssignmentCardRow extends AssignmentCard {
  AssignmentCardRow(Assignment assignment, bool showID, bool showTitle, bool showDescription, bool showPP, bool showDueDate, bool showHasSubmitted) : super(assignment, showID, showTitle, showDescription, showPP, showDueDate, showHasSubmitted);

  @override
  Widget build(BuildContext context) {
        return getInfo();
    }
}