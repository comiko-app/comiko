import 'package:comiko/pages/artist_page.dart';
import 'package:comiko/pages/event_page.dart';
import 'package:comiko/widgets/search_popup.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';

class RoutingAssistant {
  static MaterialPageRoute eventPage(Event event) => MaterialPageRoute(
        builder: (_) => EventPage(event: event),
      );

  static void searchPopup(BuildContext context) {
    showDialog(context: context, child: SearchPopup());
  }

  static MaterialPageRoute artistPage(Artist artist) =>
      MaterialPageRoute(builder: (_) => ArtistPage(artist: artist));
}
