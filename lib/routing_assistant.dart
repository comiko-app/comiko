import 'package:comiko/app_state.dart';
import 'package:comiko/pages/artist_page.dart';
import 'package:comiko/pages/event_page.dart';
import 'package:comiko/widgets/search_popup.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:comiko_shared/models.dart';

class RoutingAssistant {
  static MaterialPageRoute eventPage(Event event) {
    return new MaterialPageRoute(
      builder: (_) => new EventPage(event: event),
    );
  }

  static void searchPopup(BuildContext context, Store<AppState> store) {
    showDialog(context: context, child: new SearchPopup(store: store));
  }

  static MaterialPageRoute artistPage(String id) {
    return new MaterialPageRoute(builder: (_) => new ArtistPage(artistId: id));
  }
}
