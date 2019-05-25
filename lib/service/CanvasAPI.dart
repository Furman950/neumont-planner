import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:neumont_planner/models/objects.dart';
import 'package:neumont_planner/service/abstractServices/CanvasService.dart';

class CanvasAPI implements CanvasService {
  String _baseEndPoint = "https://lms.neumont.edu/api/v1/";

  @override
  Future<List<Assignment>> getAssignments(
      DateTime from, DateTime to, String userId) {
    // TODO: implement getAssignments
    return null;
  }

  @override
  Future<List<Course>> getCourses(String userId) async {
    final response = await http.get(_baseEndPoint + "courses?enrollment_state=active",
        headers: {HttpHeaders.authorizationHeader: "Bearer " + userId});
    final responseJson = json.decode(response.body);
    debugPrint(responseJson.toString());
        
    return null;
  }
}

class HttpsClient {}
