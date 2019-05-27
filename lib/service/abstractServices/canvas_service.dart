import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/course.dart';

abstract class CanvasService {
  Future<List<Assignment>> getAssignments(DateTime from, DateTime to, String userId);
  Future<List<Course>> getCourses(String userId);
}