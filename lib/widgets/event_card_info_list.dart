import 'package:comiko/src/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventInfoWidget extends StatelessWidget {
  final DateFormat dateTimeFormatter = new DateFormat('d MMMM yyyy HH:mm');

  final Event event = new Event(
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
      price: 110.0);

  @override
  Widget build(BuildContext context) {
    String startTime = dateTimeFormatter.format(event.start);
    String endTime = event.end == null
        ? ""
        : " - ${dateTimeFormatter.format(
        event.end)}";

    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.slideshow),
            title: new Text(event.name),
            subtitle: new Text(event.artist),
          ),
          new ListTile(
            leading: const Icon(Icons.description),
            title: new Text(event.description),
          ),
          new Divider(height: 32.0),
          new ListTile(
            leading: const Icon(Icons.location_city),
            title: new Text(event.place),
          ),
          new ListTile(
            leading: const Icon(Icons.add_location),
            title: new Text(event.address),
            subtitle: new Text(event.city),
          ),
          new ListTile(
            leading: const Icon(Icons.monetization_on),
            title: new Text("${event.price.toStringAsFixed(2)}\$"),
          ),
          new ListTile(
            leading: const Icon(Icons.date_range),
            title: new Text("$startTime$endTime"),
          ),
        ],
      ),
    );
  }
}
