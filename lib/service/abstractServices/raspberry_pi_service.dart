import 'package:neumont_planner/models/objects/custom_event.dart';

abstract class RaspberryPiService {
  void createEvent(CustomEvent event, String userId);
  void updateEvent(CustomEvent event, String userId);
  void deleteEvent(String eventId, String userId);
  Future<List<CustomEvent>> getAllEventsForUser(String userId);
}