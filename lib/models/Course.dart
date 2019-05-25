import 'dart:convert';

import 'package:neumont_planner/models/objects.dart';

List<Course> courseFromJson(String str) => new List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
    int id;
    String name;
    int accountId;
    DateTime startAt;
    DateTime createdAt;
    String courseCode;
    DateTime endAt;

    Course({
        this.id,
        this.name,
        this.accountId,
        this.startAt,
        this.createdAt,
        this.courseCode,
        this.endAt
    });

    factory Course.fromJson(Map<String, dynamic> json) => new Course(
        id: json["id"],
        name: json["name"],
        accountId: json["account_id"],
        startAt: DateTime.parse(json["start_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        courseCode: json["course_code"],
        endAt: DateTime.parse(json["end_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "account_id": accountId,
        "start_at": startAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "course_code": courseCode,
        "end_at": endAt.toIso8601String(),
    };
}