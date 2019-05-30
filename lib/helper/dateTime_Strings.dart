String getHourAndMinuteByTime(DateTime time){
  return getHourMilitary(time.hour)+":"+getMinute(time.minute);
}

String getHourAndMinute(int hour, int min){
  return getHourMilitary(hour)+":"+getMinute(min);
}

String getHourMilitary(int time){
  String hour = time.toString();
  if(hour.length == 1){
    hour = "0$hour";
  }

  return hour;
}

String getMinute(int time){
  String min = time.toString();
  if(min.length == 1){
    min = "0$min";
  }

  return min;
}