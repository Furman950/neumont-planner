import 'dart:convert';

List<CustomEvent> customEventFromJson(String str) => new List<CustomEvent>.from(json.decode(str).map((x) => CustomEvent.fromJson(x)));

String customEventToJson(List<CustomEvent> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class CustomEvent {
    String id;
    NewDocument newDocument;
    String title;
    dynamic description;
    dynamic customEventId;
    dynamic start;
    dynamic end;

    CustomEvent({
        this.id,
        this.newDocument,
        this.title,
        this.description,
        this.customEventId,
        this.start,
        this.end,
    });

    factory CustomEvent.fromJson(Map<String, dynamic> json) => new CustomEvent(
        id: json["_id"],
        newDocument: NewDocument.fromJson(json["newDocument"]),
        title: json["title"] == null ? null : json["title"],
        description: json["description"],
        customEventId: json["id"],
        start: json["start"],
        end: json["end"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "newDocument": newDocument.toJson(),
        "title": title == null ? null : title,
        "description": description,
        "id": customEventId,
        "start": start,
        "end": end,
    };
}

class NewDocument {
    String name;
    String description;
    String id;
    String start;
    String end;
    String title;

    NewDocument({
        this.name,
        this.description,
        this.id,
        this.start,
        this.end,
        this.title,
    });

    factory NewDocument.fromJson(Map<String, dynamic> json) => new NewDocument(
        name: json["Name"] == null ? null : json["Name"],
        description: json["Description"],
        id: json["Id"],
        start: json["Start"],
        end: json["End"],
        title: json["title"] == null ? null : json["title"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name == null ? null : name,
        "Description": description,
        "Id": id,
        "Start": start,
        "End": end,
        "title": title == null ? null : title,
    };
}