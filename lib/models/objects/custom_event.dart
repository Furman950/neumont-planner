import 'dart:convert';
import 'dart:math';
import 'package:uuid/uuid.dart';

import 'objects.dart';

List<CustomEvent> eventsFromJson(String str) => new List<CustomEvent>.from(
    json.decode(str).map((x) => CustomEvent.fromJson(x)));

String eventsToJson(List<CustomEvent> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class CustomEvent extends GuiObject {
  String id;
  int userId;
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;

  CustomEvent({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.startTime,
    this.endTime,
  }) : super(description, title, startTime) {
    this.id = createMongoId();
  }

  factory CustomEvent.fromJson(Map<String, dynamic> json) => new CustomEvent(
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
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
      };

  String createMongoId() {
    var timeStamp = (DateTime.now().millisecondsSinceEpoch / 1000).round().toRadixString(16);
    String random = "";
    var r = new Random();

    for (var i = 0; i < 16; i++) {
        random += r.nextInt(16).toRadixString(16);
    }

    return timeStamp + random;
  }
}
