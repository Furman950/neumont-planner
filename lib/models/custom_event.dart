import 'package:flutter/material.dart';
import 'package:neumont_planner/models/objects.dart';

abstract class EventCard extends StatelessWidget {
  // final Event _event;
  // EventCard(this._event);

  List<Widget> getList() {
    List<Widget> eventList = [];
    eventList.add(Text("EventList is empty"));
    return eventList;
  }
}

class EventCartListRow extends EventCard {
  EventCartListRow(Event event);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getList(),
    );
  }
}

class EventCartListColumn extends EventCard {
  EventCartListColumn(Event event);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getList(),
    );
  }
}
