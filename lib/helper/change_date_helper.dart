abstract class TimeChanger{

  DateTime change(DateTime date, int change);
}

class ChangeMonth extends TimeChanger{
  @override
  DateTime change(DateTime date, int change) {
      return new DateTime(date.year,date.month + change,date.day);
  }
}

class ChangeWeek extends TimeChanger{
  @override
  DateTime change(DateTime date, int change) {
    if(change < 0){
      change = 0 - change;
      for (var i = 0; i < change; i++) {
        date = date.subtract(Duration(days: 7));
      }
    }else if(change > 0){
      for (var i = 0; i < change; i++) {
        date = date.add(Duration(days: 7));
      }    
    }
    return date;
  }
}

class ChangeDay extends TimeChanger{
  @override
  DateTime change(DateTime date, int change) {
    if(change < 0){
      change = 0 - change;
      for (var i = 0; i < change; i++) {
        date = date.subtract(Duration(days: 1));
      }
    }else if(change > 0){
      for (var i = 0; i < change; i++) {
        date = date.add(Duration(days: 1));
      }    
    }
    return date;
  }
}