
import 'package:neumont_planner/models/objects/objects.dart';

List<GuiObject> getObjectsByHour(DateTime filter, List<GuiObject> objs){

  List<GuiObject> toBeReturned = [];

  objs = getObjectsByDay(filter, objs);

  objs.forEach((x) => {
    if(x.sortDateTime.hour == filter.hour){
      toBeReturned.add(x)
    }
  });

  return toBeReturned;
}

List<GuiObject> getObjectsByWeek(DateTime filter, List<GuiObject> objs){
  List<GuiObject> toBeReturned = [];

  objs.forEach((x) =>{
    if(x.sortDateTime.isAfter(filter) && x.sortDateTime.isBefore(filter.add(Duration(days: 6)))){
      toBeReturned.add(x)
    }
  }
);

  return toBeReturned;
}

List<GuiObject> getObjectsByDay(DateTime filter, List<GuiObject> objs){

  List<GuiObject> toBeReturned = [];

  objs.forEach((x) => {
    if(x.sortDateTime.day == filter.day && x.sortDateTime.month == filter.month && x.sortDateTime.year == filter.year){
      toBeReturned.add(x)
    }
  });

  return toBeReturned;
}

List<GuiObject> getObjectsByMonth(DateTime filter, List<GuiObject> objs){

  List<GuiObject> toBeReturned = [];

  objs.forEach((x) => {
    if(x.sortDateTime.month == filter.month && x.sortDateTime.year == filter.year){
      toBeReturned.add(x)
    }
  });

  return toBeReturned;
}