class  Assignment extends GuiObject {
  DateTime dueAt;
  double pp;
  bool hasSubmitted;

  Assignment(int id,String title, String description, this.pp, this.dueAt,this.hasSubmitted) : super(id, description,title);
}

class Course extends GuiObject {
  String courseFormat;
  String courseGrade;

  Course(int id,String title, String description) : super(id, description,title);
}

class Event extends GuiObject{
  DateTime startTime;
  DateTime endTime;

  Event(int id, String title, String description) : super(id, description,title);
}

abstract class GuiObject{
  String title;
  int id;
  String description;

  GuiObject(this.id,this.description,this.title);
}