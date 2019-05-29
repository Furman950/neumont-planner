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