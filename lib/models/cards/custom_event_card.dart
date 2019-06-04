import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/dateTime_Strings.dart';
import 'package:neumont_planner/models/objects/custom_event.dart';

class CustomEventCard extends StatelessWidget {

    final CustomEvent _event;
    final bool _showTitle;
    final bool _showDescription;
    final bool _showTime;
    final bool _showUserId;

    CustomEventCard(this._event,this._showTitle,this._showDescription,this._showTime,this._showUserId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(getEventCardText()),
      );
    }
      
    String getEventCardText() {
      String s = "\t\t";

    if(_showUserId){
      s += "|User ${_event.userId}|";
    }

      if(_showTitle){
        s += "${_event.title} ";
      }

      if(_showDescription){
        s += "${parseDescription(_event.description, 180)}";
      }

      if(_showTime){
        String timeString = "${_event.startTime.month}/${_event.startTime.day}/${_event.startTime.year} ";
        if(_event.endTime != null){
          timeString += "- ${_event.endTime.month}/${_event.endTime.day}/${_event.endTime.year} ";
        }
        s += "$timeString ";
      }
      return s;
    }
}