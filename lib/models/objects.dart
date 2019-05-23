class  Assignment extends GuiObject {
  final DateTime dueAt;
  final double pp;
  final bool hasSubmitted;

  Assignment(int id,String title, String description, this.pp, this.dueAt,this.hasSubmitted) : super(id, description,title,dueAt);
}

class Course extends GuiObject {
  final String courseFormat;
  final String courseGrade;
  final DateTime classTime;

  Course(int id, String description, String title,  this.classTime, this.courseFormat, this.courseGrade) : super(id, description, title, classTime);

}

class Event extends GuiObject{
  final DateTime startTime;
  final DateTime endTime;

  Event(int id, String description, String title, this.startTime, this.endTime) : super(id, description, title, startTime);

}

abstract class GuiObject{
  final String title;
  final int id;
  final String description;
  final DateTime sortDateTime;

  GuiObject(this.id,this.description,this.title,this.sortDateTime);
}