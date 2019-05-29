
import 'package:neumont_planner/models/objects/objects.dart';

List<GuiObject> getObjectsByHour(String hour, List<GuiObject> objs){

  List<GuiObject> toBeReturned = [];

  objs.forEach((x) => {
    if(x.sortDateTime.hour.toString() == hour){
      toBeReturned.add(x)
    }
  });

  return toBeReturned;
}

List<GuiObject> getObjectsByDay(int day, List<GuiObject> objs){

  List<GuiObject> toBeReturned = [];

  objs.forEach((x) => {
    if(x.sortDateTime.day == day){
      toBeReturned.add(x)
    }
  });

  return toBeReturned;
}

List<GuiObject> getObjectsByMonth(int month, List<GuiObject> objs){

  List<GuiObject> toBeReturned = [];

  objs.forEach((x) => {
    if(x.sortDateTime.month == month){
      toBeReturned.add(x)
    }
  });

  return toBeReturned;
}