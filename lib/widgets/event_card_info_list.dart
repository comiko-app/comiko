import 'package:flutter/material.dart';
import 'package:comiko/src/models/event.dart';

class EventInfoWidget extends StatelessWidget {
  List<Widget> content = [];

  final List<Event> events = [
    new Event(name: "Many Names", start: new DateTime.now(), address: "123 random street", city: "MuchCity", price: 50.0),
    new Event(name: "Many Names", start: new DateTime.now(), address: "123 random street", city: "MuchCity", price: 50.0),
  ];

  EventInfoWidget() {
    for (int i = 0; i < events.length; i++) {
      content.addAll([
        new Text(events[i].name),
        new Text(events[i].city),
        new Text(events[i].address),
        new Text("${events[i].price.toString()}\$"),
        new Text("${events[i].start} - ${events[i].end}"),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
      children: content,
    ));
  }
}
