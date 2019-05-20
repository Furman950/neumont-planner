class  Assignment extends GuiObject {
  DateTime dueAt;
  double pp;
  bool hasSubmitted;

  Assignment(int id, String description, this.pp, this.dueAt,this.hasSubmitted) : super(id, description);
}

class Course extends GuiObject {
  String courseFormat;
  String courseGrade;

  Course(int id, String description) : super(id, description);
}

class Event extends GuiObject{
  DateTime startTime;
  DateTime endTime;

  Event(int id, String description) : super(id, description);
}

abstract class GuiObject{
  int id;
  String description;

  GuiObject(this.id,this.description);
}