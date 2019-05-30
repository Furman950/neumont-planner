import 'package:flutter/material.dart';

class CustomEventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(getEventCardText()),
      );
    }
      
    String getEventCardText() {
      String s = "Event";

      return s;
    }
}