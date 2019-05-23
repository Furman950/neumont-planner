import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects.dart';

import '../main.dart';

abstract class AbstractView extends StatelessWidget {
  final List<Assignment> assignments; 
  final List<Course> courses; 
  final List<Event> events; 
  final void Function(View,DateTime) changeView;

  AbstractView(this.assignments, this.courses, this.events, this.changeView) ;
}