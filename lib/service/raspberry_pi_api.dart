import 'dart:_http';
import 'dart:async';

import 'package:neumont_planner/models/objects/custom_event.dart';

import 'abstractServices/raspberry_pi_service.dart';
import 'package:http/http.dart' as http;

class RaspberryPiAPI implements RaspberryPiService {
  String _baseEndPoint = "https://ferminsandoval.com:5585/api/events/";

  @override
  void createEvent(CustomEvent event, String userId) {
    
  }

  @override
  void deleteEvent(String eventId, String userId) {
    // TODO: implement deleteEvent
  }

  @override
  Future<List<CustomEvent>> getAllEventsForUser(String userId) async {
    final response = await http.get(
      _baseEndPoint + "all",
      headers: { HttpHeaders.authorizationHeader: "Bearer " + userId }
    );

    var completer = new Completer<List<CustomEvent>>();
    completer.complete(eventsFromJson(response.body));
    
    return completer.future;
  }

  @override
  void updateEvent(CustomEvent event, String userId) {
    // TODO: implement updateEvent
  }
}

