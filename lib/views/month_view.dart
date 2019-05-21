import 'package:flutter/material.dart';

class MonthView extends StatefulWidget {
  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  List<Container> monthView = [];

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    int offset = 0;

    //switch(today.month-1){
    //  case 1:
    //    break;
    //  case 2:
    //    break;
    //  case 3:
    //    break;
    //  case 4:
    //    break;
    //  case 5:
    //    offset = -2;
    //    break;
    //  case 6:
    //    offset = -5;
    //    break;
    //  case 7:
    //    offset = 0;
    //    break;
    //  case 8:
    //   offset = -3;
    //    break;
    //  case 9:
    //    offset = 1;
    //    break;
    //  case 10:
    //    offset = -1;
    //    break;
    //  case 11:
    //    offset = -4;
    //    break;
    //  case 12:
    //    offset = 1;
    //    break;
    //  default:
    //    break;
    //}

    for (int i = 0; i < 42; i++) {
      offset = -2;
      DateTime day = new DateTime(today.year, today.month, i+offset);
      Color color = Colors.grey;

      if (day.month == today.month){
        color = Colors.yellow;
      }
      else {
        color = Colors.grey;
      }

      if (day.day == today.day && day.month == today.month && day.year == today.year){
        color = Colors.orange;
      }

      monthView.add(
        new Container(
          width: 100,
          height: 100,
          child: new RaisedButton(
            color: color,
            child: new Text('${day.day}'),
            //onPressed: () => new DayView(day),
            onPressed: () => print('${day.toString()}'),
          ),
        ),
      );
    }

    return Expanded(
      child: GridView.count(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: monthView
      )
    );
  }
}