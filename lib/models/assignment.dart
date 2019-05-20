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

  List<Widget> getWidgetList() {
    List<Widget> list = [];

    if(_showID){
      var id =  _assignment.id;
      list.add(Text("$id"));
    }

      if(_showTitle){
        list.add(Text(_assignment.title));
      }

      if(_showDescription){
        list.add(Text(_assignment.description));
      }

      if(_showPP){
        var pp = _assignment.pp;
        list.add(Text("$pp"));
      }

      if(_showDueDate){
        var date = _assignment.dueAt;
        list.add(Text("$date"));
      }

      if(_showHasSubmitted){
        var submitted = _assignment.hasSubmitted.toString();
        list.add(Text(submitted));
      }
      return  list;
    }
}

class AssignmentCardRow extends AssignmentCard {
  AssignmentCardRow(Assignment assignment, bool showID, bool showTitle, bool showDescription, bool showPP, bool showDueDate, bool showHasSubmitted) : super(assignment, showID, showTitle, showDescription, showPP, showDueDate, showHasSubmitted);

  @override
  Widget build(BuildContext context) {
      return Row(
        children: getWidgetList(),
      );
    }
}

class AssignmentCardColumn extends AssignmentCard{
  AssignmentCardColumn(Assignment assignment, bool showID, bool showTitle, bool showDescription, bool showPP, bool showDueDate, bool showHasSubmitted) : super(assignment, showID, showTitle, showDescription, showPP, showDueDate, showHasSubmitted);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getWidgetList()
    );
  }
}