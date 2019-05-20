import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeekView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  List<String> weekViewStuff = [];
  @override
  Widget build(BuildContext context) {
    //FOR THOSE READING:
    //describeEnum returns the enum value in string "value", otherwise it returns "yourEnum.value"

    //get current datetime
    DateTime today = DateTime.now();

    //get first day of current week
    DateTime _thisWeek = today.subtract(new Duration(days: today.weekday));

    for (var i = 6, j = 0; j < 7; i++, j++) {
      // print("${describeEnum(_WeekDay.values[i])} ${_thisWeek.month}/${(_thisWeek.day+j)}");
      weekViewStuff.add(
          "${describeEnum(_WeekDay.values[i])} ${_thisWeek.month}/${(_thisWeek.day + j)}");
      if (i == 6) {
        i = -1;
      }
    }

    // return Center(child: ListView(children: weekViewStuff.map(index)=>Card(),),).toString();
    return Expanded(
        child: ListView(
            children: weekViewStuff
                .map((index) => Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[Text(index)],
                      ),
                    )))
                .toList()));
  }
}

enum _WeekDay {
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURESDAY,
  FRIDAY,
  SATURDAY,
  SUNDAY
}
