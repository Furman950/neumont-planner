class  Assignment extends GuiObject {
  DateTime dueAt;
  String pp;
  bool hasSubmitted;
}

class Course extends GuiObject {
  String courseFormat;
  String courseGrade;
}

class Event extends GuiObject{
  DateTime startTime;
  DateTime endTime;
}

abstract class GuiObject{
  int id;
  String description;
}