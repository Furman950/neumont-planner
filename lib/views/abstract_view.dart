import 'package:flutter/material.dart';
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/course.dart';
import 'package:neumont_planner/models/objects.dart';

import '../main.dart';

abstract class AbstractView extends StatelessWidget {
  final List<Assignment> assignments; 
  final List<Course> courses; 
  final List<Event> events; 
  final void Function(View,DateTime) changeView;
  List<GuiObject>  getMasterList(){
    List<GuiObject> list = [];
    list.addAll(assignments);
    list.addAll(courses);
    list.addAll(events);

     list.sort(  (left,right) => left.sortDateTime.compareTo(right.sortDateTime));
     return list;
  }

  AbstractView(this.assignments, this.courses, this.events, this.changeView) ;
}