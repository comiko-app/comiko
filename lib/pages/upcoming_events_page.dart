import 'package:comiko/models.dart';
import 'package:flutter/material.dart';
import 'package:comiko/widgets/event_card.dart';

class UpcomingEventsPage extends StatelessWidget {
  final List<Event> events;

  UpcomingEventsPage(this.events);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      body: new GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: orientation == Orientation.portrait ? 1 : 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: events
            .map((Event e) => new EventCardViewModel(event: e))
            .map((EventCardViewModel vm) => new EventCard(vm))
            .toList(),
      ),
    );
  }
}
