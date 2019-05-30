import 'dart:convert';

import 'package:neumont_planner/models/objects/objects.dart';

List<Assignment> assignmentsFromJson(String str) => new List<Assignment>.from(json.decode(str).map((x) => Assignment.fromJson(x)));

String assignmentsToJson(List<Assignment> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Assignment extends GuiObject{
    int id;
    String description;
    DateTime dueAt;
    int pp;
    String gradingType;
    int allowedAttempts;
    int courseId;
    String name;
    bool hasSubmitted;
    bool isQuizAssignment;

    Assignment({
        this.id,
        this.description,
        this.dueAt,
        this.pp,
        this.gradingType,
        this.allowedAttempts,
        this.courseId,
        this.name,
        this.hasSubmitted,
        this.isQuizAssignment,
    }) : super(description, name, dueAt);

    factory Assignment.fromJson(Map<String, dynamic> json) => new Assignment(
        id: json["id"],
        description: json["description"],
        dueAt: DateTime.parse(json["due_at"]),
        pp: json["points_possible"],
        gradingType: json["grading_type"],
        allowedAttempts: json["allowed_attempts"],
        courseId: json["course_id"],
        name: json["name"],
        hasSubmitted: json["has_submitted_submissions"],
        isQuizAssignment: json["is_quiz_assignment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "due_at": dueAt.toIso8601String(),
        "points_possible": pp,
        "grading_type": gradingType,
        "allowed_attempts": allowedAttempts,
        "course_id": courseId,
        "name": name,
        "has_submitted_submissions": hasSubmitted,
        "is_quiz_assignment": isQuizAssignment,
    };
}