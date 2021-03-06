

import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/models/objects/custom_event.dart';
import 'package:neumont_planner/models/objects/objects.dart';

import '../main.dart';

abstract class AbstractView extends StatelessWidget {
  final List<Assignment> assignments; 
  final List<Course> courses; 
  final List<CustomEvent> events; 
  final void Function(View,DateTime) changeView;
  final DateTime selectedDate;
  
  List<GuiObject>  getMasterList(){
    List<GuiObject> list = [];
    list.addAll(assignments);
    list.addAll(courses);
    list.addAll(events);

     list.sort(  (left,right) => left.sortDateTime.compareTo(right.sortDateTime));
     return list;
  }

  List<Assignment> getSortedAssignments(){
    List<Assignment> list = [];

    list.addAll(assignments);
     list.sort(  (left,right) => left.sortDateTime.compareTo(right.sortDateTime));
     return list;
  }

  List<CustomEvent> getSortedEvents(){
    List<CustomEvent> list = [];

    list.addAll(events);
     list.sort(  (left,right) => left.sortDateTime.compareTo(right.sortDateTime));
     return list;
  }

    List<Course> getSortedCourses(){
    List<Course> list = [];

    list.addAll(courses);
     list.sort(  (left,right) => left.sortDateTime.compareTo(right.sortDateTime));
     return list;
  }

  AbstractView(this.assignments, this.courses, this.events, this.changeView,this.selectedDate) ;
}