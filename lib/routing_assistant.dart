import 'package:comiko/models.dart';
import 'package:comiko/pages/event_page.dart';
import 'package:flutter/material.dart';

class RoutingAssistant {
  static MaterialPageRoute eventPage(Event event) {
    return new MaterialPageRoute(
      builder: (_) => new EventPage(event: event),
    );
  }
}
