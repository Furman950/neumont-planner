
import 'package:neumont_planner/models/objects/objects.dart';

abstract class RaspberryPiService {
  void createEvent(Event event, String userId);
  void updateEvent(Event event, String userId);
  void deleteEvent(String eventId, String userId);
  List<Event> getAllEvents(String userId);
}