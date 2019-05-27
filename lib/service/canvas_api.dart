import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:neumont_planner/models/assignment.dart';
import 'package:neumont_planner/models/course.dart';
import 'package:neumont_planner/service/abstractServices/canvas_service.dart';

class CanvasAPI implements CanvasService {
  String _baseEndPoint = "https://lms.neumont.edu/api/v1/";

  @override
  Future<List<Assignment>> getAssignments(DateTime from, DateTime to, String userId) async {
    List<Assignment> assignmentList = new List<Assignment>();
    var listOfCourses = await getCourses(userId);
    for (final course in listOfCourses) {
      final response = await http.get(
          _baseEndPoint + course.id.toString() + "/assignments",
          headers: {HttpHeaders.authorizationHeader: "Bearer " + userId});
      var tempAssignmentList = assignmentsFromJson(response.body);
      assignmentList.addAll(tempAssignmentList);
    }

    var completer = new Completer<List<Assignment>>();
    return completer.future;
  }

  @override
  Future<List<Course>> getCourses(String userId) async {
    final response = await http.get(
        _baseEndPoint + "courses?enrollment_state=active",
        headers: {HttpHeaders.authorizationHeader: "Bearer " + userId});

    var completer = new Completer<List<Course>>();
    completer.complete(coursesFromJson(response.body));
    return completer.future;
  }
}

class HttpsClient {}
