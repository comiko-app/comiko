import 'package:flutter/material.dart';
import 'package:comiko/src/models/event.dart';

class EventInfoWidget extends StatelessWidget {
  List<Widget> content = [];

  final List<Event> events = [
    new Event(
        name: "Many Names",
        start: new DateTime.now(),
        end: new DateTime.now(),
        address: "123 random street",
        city: "MuchCity",
        price: 50.0),
    new Event(
        name: "Many Names",
        start: new DateTime.now(),
        address: "123 random street",
        city: "MuchCity",
        price: 50.0),
  ];

  EventInfoWidget() {
    for (int i = 0; i < events.length; i++) {
      Text endTime = new Text("${events[i].start} - ${events[i].end}");
      if (events[i].end == null) {
        endTime = new Text("${events[i].start}");
      }

      content.addAll([
        new Divider(color: new Color.fromRGBO(0, 150, 200, 0.9), height: 50.0),
        new ListTile(
          leading: const Icon(Icons.supervisor_account),
          title: new Text(events[i].name),
        ),
        new ListTile(
          leading: const Icon(Icons.location_city),
          title: new Text(events[i].city),
        ),
        new ListTile(
          leading: const Icon(Icons.add_location),
          title: new Text(events[i].address),
        ),
        new ListTile(
          leading: const Icon(Icons.monetization_on),
          title: new Text("${events[i].price.toStringAsPrecision(2)}\$"),
        ),
        new ListTile(
          leading: const Icon(Icons.date_range),
          title: endTime,
        ),
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
