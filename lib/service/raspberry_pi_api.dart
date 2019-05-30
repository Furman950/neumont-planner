import 'dart:_http';
import 'dart:async';
import 'dart:io';

import 'package:neumont_planner/models/objects/custom_event.dart';

import 'abstractServices/raspberry_pi_service.dart';
import 'package:http/http.dart' as http;

class RaspberryPiAPI implements RaspberryPiService {
  String _baseEndPoint = "https://ferminsandoval.com:5585/api/events/";

  @override
  void createEvent(CustomEvent event, String accessToken) async {
    await http.post(_baseEndPoint + "new",
    body: event.toJson(),
    headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});
  }

  @override
  void deleteEvent(String eventId, String accessToken) async {
    await http.delete(_baseEndPoint + "delete/" + eventId,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});
  }

  @override
  Future<List<CustomEvent>> getAllEventsForUser(String accessToken) async {
    final response = await http.get(_baseEndPoint + "all",
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});

    var completer = new Completer<List<CustomEvent>>();
    completer.complete(eventsFromJson(response.body));

    return completer.future;
  }

  @override
  void updateEvent(CustomEvent event, String accessToken) async {
    await http.patch(_baseEndPoint + "edit/" + event.id,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});
  }

  @override
  Future<CustomEvent> getEventById(String eventId, String accessToken) async {
    final response = await http.get(_baseEndPoint + eventId,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});

    var completer = new Completer<CustomEvent>();
    completer.complete(eventsFromJson(response.body)[0]);

    return completer.future;
  }
}
