import 'package:comiko/app_state.dart';
import 'package:comiko/pages/artist_page.dart';
import 'package:comiko/pages/event_page.dart';
import 'package:comiko/widgets/search_popup.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class RoutingAssistant {
  static MaterialPageRoute eventPage(Event event) => new MaterialPageRoute(
        builder: (_) => new EventPage(event: event),
      );

  static void searchPopup(BuildContext context, Store<AppState> store) {
    showDialog(context: context, child: new SearchPopup(store: store));
  }

  static MaterialPageRoute artistPage(Artist artist) =>
      new MaterialPageRoute(builder: (_) => new ArtistPage(artist: artist));
}
