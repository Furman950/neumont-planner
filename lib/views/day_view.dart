import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neumont_planner/helper/change_date_helper.dart';
import 'package:neumont_planner/helper/dateTimeFilter.dart';
import 'package:neumont_planner/models/cards/assignment_card.dart';
import 'package:neumont_planner/models/cards/course_card.dart';
import 'package:neumont_planner/models/cards/custom_event_card.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/models/objects/objects.dart';

import '../main.dart';
import 'abstract_view.dart';

class DayView extends AbstractView{

  DayView(List<Assignment> assignments, List<Course> courses, List<CustomEvent> events, changeView,DateTime selected) : super(assignments, courses, events, changeView,selected);

  @override
  Widget build(BuildContext context) {
    double start = 0;
    double update = 0;
    return Expanded(
      child: GestureDetector(
        child: Container(child:buildWidgetForDay(getObjectsByDay(selectedDate, getMasterList())),color:  Colors.white,),
        onPanStart: (DragStartDetails details) {
          start = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          update = details.globalPosition.dx - start;
        },
        onPanEnd: (DragEndDetails details) {
          if (update >  start) {
            changeView(View.DAY, ChangeDay().change(selectedDate, 1));
          } else {
            changeView(View.DAY, ChangeDay().change(selectedDate, -1));
          }
        }
      )
    );
  }

  ListView buildListView(objs){
    List<Widget> cardList = [];
    for (var obj in objs) {
      if(obj is Assignment){
        cardList.add(AssignmentCard(obj, false, true, true, true, false, false, false, true, true, false));
      }else if (obj is CustomEvent) {
        cardList.add(CustomEventCard(obj, true, true, true, false));
      }else if(obj is Course){
        cardList.add(CourseCard(obj, false, true, false, true, false, false, true));
      }
    }

    return ListView(
      children: cardList,
    );
  }


    Widget buildWidgetForDay(List<GuiObject> objs){

    if(objs.length == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.schedule),
              Text("Nothing To Do"),
          ],
      )

        ],
       );
    }else{
      return buildListView(objs);
    }
  }          
}
