import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects/Course.dart';

class CourseCard extends StatelessWidget {
  final Course _course;
  final bool _showId;
  final bool _showName;
  final bool _showAccountId;
  final bool _showCreatedAt;
  final bool _showStartAt;
  final bool _showEndAt;
  final bool _showCourseCode;

  const CourseCard(this._course, this._showId, this._showName, this._showAccountId, this._showStartAt, this._showCreatedAt, this._showCourseCode, this._showEndAt);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(getTextOfCourse()),
    );
  }

  String getTextOfCourse(){
    String s = "";

    if(_showId){
      s += "${_course.id} " ;
    }

    if (_showName){
      s += "${_course.name} ";
    }

    if(_showAccountId){
      s += "${_course.accountId} ";
    }

    if(_showCreatedAt){
      s += "created: ${_course.createdAt.month} - ${_course.createdAt.day} - ${_course.createdAt.year} ";
    }

    if(_showStartAt){
      s += "Starts: ${_course.startAt.month}/${_course.startAt.day}/${_course.startAt.year} ";
    }

    if(_showEndAt){
      s += "Starts: ${_course.endAt.month}/${_course.endAt.day}/${_course.endAt.year} ";
    }

    if(_showCourseCode){
      s += "code ${_course.courseCode} ";
    }
    
    return s;
  }
}