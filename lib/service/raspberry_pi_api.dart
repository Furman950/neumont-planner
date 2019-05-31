import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:neumont_planner/models/objects/custom_event.dart';

import 'abstractServices/raspberry_pi_service.dart';

class RaspberryPiAPI implements RaspberryPiService {
  String _baseEndPoint = "https://ferminsandoval.com:5585/api/events/";

  @override
  void createEvent(CustomEvent event, String accessToken) async {
    print("_______________________CREATE_EVENT____________________________");
    var client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    var request = await client.postUrl(Uri.parse(_baseEndPoint + "new"));
    request.headers.set("Authorization", "Bearer " + accessToken);
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(event.toJson())));
    var response = await request.close();
    var reply = await response.transform(utf8.decoder).join();
    print(reply);
    print("_______________END_CREATE_EVENT________________");
  }

  @override
  void deleteEvent(String eventId, String accessToken) async {
    print("_______________________DELETE__EVENT____________________________");
    var client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    var request =
        await client.deleteUrl(Uri.parse(_baseEndPoint + "delete/" + eventId));
    request.headers.set("Authorization", "Bearer " + accessToken);
    var response = await request.close();
    var reply = await response.transform(utf8.decoder).join();
    print(reply);
    print("_______________END_DELETE_EVENT________________");
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
