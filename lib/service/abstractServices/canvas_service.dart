import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';

abstract class CanvasService {
  Future<List<Assignment>> getAssignments(DateTime from, DateTime to, String userId);
  Future<List<Course>> getCourses(String userId);
}