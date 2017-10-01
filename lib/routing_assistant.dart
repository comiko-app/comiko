import 'package:comiko/app_state.dart';
import 'package:comiko/models.dart';
import 'package:comiko/pages/event_page.dart';
import 'package:comiko/widgets/search_popup.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class RoutingAssistant {
  static MaterialPageRoute eventPage(Event event) {
    return new MaterialPageRoute(
      builder: (_) => new EventPage(event: event),
    );
  }

  static void searchPopup(BuildContext context, Store<AppState> store) {
    var route = new MaterialPageRoute(
      builder: (_) => new SearchPopup(store: store),
      fullscreenDialog: true,
    );
    Navigator.of(context).push(route);
  }
}
