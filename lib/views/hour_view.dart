import 'package:flutter/material.dart';
import 'package:neumont_planner/helper/dateTimeFilter.dart';
import 'package:neumont_planner/helper/dateTime_Strings.dart';
import 'package:neumont_planner/models/cards/assignment_card.dart';
import 'package:neumont_planner/models/cards/course_card.dart';
import 'package:neumont_planner/models/cards/custom_event_card.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/models/objects/objects.dart';

import '../main.dart';
import 'abstract_view.dart';

class HourView extends AbstractView {
  
  HourView(List<Assignment> assignments, List<Course> courses,List<CustomEvent> events, changeView,DateTime selected): super(assignments, courses, events, changeView,selected);

  @override
  Widget build(BuildContext context) {

    List<int> hourList = [];

    double start = 0;
    double update = 0;

    for (var i = 0; i < 24; i++) {
      hourList.add(i);
    }
    return Expanded(
      child: GestureDetector(
        child: Padding(
        padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Expanded(child: 
                ListView(
                  children: hourList.map((hour) => Container(
                    child: Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child:Text(getHourAndMinute(hour,0))
                        ,),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: buildWidgetListForHour(getObjectsByHour(new DateTime(selectedDate.year,selectedDate.month,selectedDate.day,hour),getMasterList()))
                          )
                        )
                      ])
                    )).toList())
                ,)
              ],
            )
          ),
          onPanStart: (DragStartDetails details) {
            start = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          update = details.globalPosition.dx - start;
        },
        onPanEnd: (DragEndDetails details) {
          if (update >  start) {
            changeView(View.DAY, selectedDate.add(Duration(hours:24)));
          } else {
            changeView(View.DAY, selectedDate.subtract(Duration(hours:24)));
          }
        },
      ), 
    );
  }
  List<Widget> buildWidgetListForHour(List<GuiObject> objs ){
    List<Widget> toBeReturned = [];

    for (var obj in objs) {
      if(obj is Assignment){
        toBeReturned.add(AssignmentCard(obj, false, true, true, true, false, false, false, true, true, false));
      }else if (obj is CustomEvent) {
        toBeReturned.add(CustomEventCard());
      }else if(obj is Course){
        toBeReturned.add(CourseCard(obj, false, true, false, true, false, false, false));
      }
    }
    return toBeReturned;
  }                   
}
