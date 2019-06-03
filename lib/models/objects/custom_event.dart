import 'dart:convert';
import 'dart:math';

import 'objects.dart';

List<CustomEvent> eventsFromJson(String str) => new List<CustomEvent>.from(
    json.decode(str).map((x) => CustomEvent.fromJson(x)));

CustomEvent eventFromJson(String str) => CustomEvent.fromJson(json.decode(str));

String eventsToJson(List<CustomEvent> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class CustomEvent extends GuiObject {
  String mongoId;
  int userId;
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;

  CustomEvent({
    this.mongoId,
    this.title,
    this.description,
    this.userId,
    this.startTime,
    this.endTime,
  }) : super(description, title, startTime) {
    this.mongoId = createMongoId();
  }

  factory CustomEvent.fromJson(Map<String, dynamic> json) => new CustomEvent(
        mongoId: json["mongoId"],
        title: json["title"],
        description: json["description"],
        userId: json["id"],
        startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]).toLocal(),
        endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "mongoId": mongoId,
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
