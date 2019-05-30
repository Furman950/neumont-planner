import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'objects.dart';

List<CustomEvent> eventsFromJson(String str) => new List<CustomEvent>.from(json.decode(str).map((x) => CustomEvent.fromJson(x)));

String eventsToJson(List<CustomEvent> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class CustomEvent extends GuiObject{
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
    }) : super(description, title, endTime){
      this.id = new Uuid().v4();
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
        "startTime": startTime,
        "endTime": endTime,
    };
}