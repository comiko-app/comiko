import 'package:flutter/material.dart';
import 'package:comiko/src/models/event.dart';
import 'package:intl/intl.dart';

class EventInfoWidget extends StatelessWidget {
  final DateFormat dateTimeFormatter = new DateFormat('d MMMM yyyy HH:mm');

  List<Widget> content = [];

  final List<Event> events = [
    new Event(
        name: "Many Show",
        description: "Such description, many features",
        start: new DateTime.now(),
        end: new DateTime.now(),
        address: "123 random street",
        city: "MuchCity",
        artist: "Mike Ward",
        place: "Somewhere",
        styles: "vulgaire, humour noire, chèvres",
        image: "lib/assets/martin-matte1.jpg",
        price: 110.0),
    /*new Event(
        name: "Many Names",
        start: new DateTime.now(),
        address: "123 random street",
        city: "MuchCity",
        price: 50.0),*/
  ];

  EventInfoWidget() {
    for (int i = 0; i < events.length; i++) {
      String startTime = dateTimeFormatter.format(events[i].start);
      String endTime;
      if (events[i].end == null) {
        endTime = ""; //avoid null string in display
      } else {
        endTime = " - ${dateTimeFormatter.format(events[i].end)}";
      }

      content.addAll([
        new Divider(color: new Color.fromRGBO(0, 150, 200, 0.9), height: 50.0),
        new ListTile(
          leading: const Icon(Icons.slideshow),
          title: new Text(events[i].name),
          subtitle: new Text("${events[i].artist} - (${events[i].styles})"),
        ),
        new ListTile(
          leading: const Icon(Icons.description),
          title: new Text(events[i].description),
        ),
        new ListTile(
          leading: const Icon(Icons.location_city),
          title: new Text("${events[i].place}"),
        ),
        new ListTile(
          leading: const Icon(Icons.add_location),
          title: new Text(events[i].address),
          subtitle: new Text("${events[i].city}"),
        ),
        new ListTile(
          leading: const Icon(Icons.monetization_on),
          title: new Text("${events[i].price.toStringAsFixed(2)}\$"),
        ),
        new ListTile(
          leading: const Icon(Icons.date_range),
          title: new Text(startTime + endTime),
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
