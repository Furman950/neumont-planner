import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

List<Event> eventsFromJson(String str) => new List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventsToJson(List<Event> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Event extends GuiObject{
    String id;
    int userId;
    String title;
    String description;
    DateTime startTime;
    DateTime endTime;

    Event({
        this.id,
        this.title,
        this.description,
        this.userId,
        this.startTime,
        this.endTime,
    }) : super(description, title, endTime){
      this.id = new Uuid().v4();
    }

    factory Event.fromJson(Map<String, dynamic> json) => new Event(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        userId: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "userId": userId,
        "startTime": startTime,
        "endTime": endTime,
    };
}

abstract class GuiObject{
  final String title;
  final String description;
  final DateTime sortDateTime;

  GuiObject(this.description,this.title,this.sortDateTime);
}