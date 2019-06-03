import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:neumont_planner/models/objects/Course.dart';
import 'package:neumont_planner/models/objects/assignment.dart';
import 'package:neumont_planner/service/abstractServices/canvas_service.dart';

const int FRESHMEN_ORIENTATION_COURSE = 2218131;
class CanvasAPI implements CanvasService {
  String _baseEndPoint = "https://lms.neumont.edu/api/v1/";

  @override
  Future<List<Assignment>> getAssignments(
      DateTime from, DateTime to, String userId) async {
    List<Assignment> assignmentList = new List<Assignment>();
    var listOfCourses = await getCourses(userId);
    for (final course in listOfCourses) {
      if (course.id == FRESHMEN_ORIENTATION_COURSE)
        continue;
      final response = await http.get(
          _baseEndPoint + "courses/" + course.id.toString() + "/assignments",
          headers: {HttpHeaders.authorizationHeader: "Bearer " + userId});
      var tempAssignmentList = assignmentsFromJson(response.body);
      assignmentList.addAll(tempAssignmentList);
    }

    var completer = new Completer<List<Assignment>>();
    completer.complete(assignmentList);
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
