import 'package:neumont_planner/models/objects/custom_event.dart';

abstract class RaspberryPiService {
  void createEvent(CustomEvent event, String accessToken);
  void updateEvent(CustomEvent event, String accessToken);
  void deleteEvent(String eventId, String accessToken);
  Future<CustomEvent> getEventById(String eventId, String accessToken);
  Future<List<CustomEvent>> getAllEventsForUser(String accessToken);
}