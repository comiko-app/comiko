import 'package:comiko/app_state.dart';
import 'package:comiko/pages/artist_page.dart';
import 'package:comiko/pages/event_page.dart';
import 'package:comiko/widgets/search_popup.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class RoutingAssistant {
  static MaterialPageRoute eventPage(Event event) => MaterialPageRoute(
        builder: (_) => EventPage(event: event),
      );

  static void searchPopup(BuildContext context) {
    showDialog(context: context, builder: (context) => SearchPopup());
  }

  static MaterialPageRoute artistPage(Artist artist) =>
      MaterialPageRoute(builder: (_) => ArtistPage(artist: artist));

  static sortPopup(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    showMenu(
      context: context,
      items: <PopupMenuEntry<SortingCriteria>>[
        CheckedPopupMenuItem<SortingCriteria>(
          checked: store.state.sortingCriteria == SortingCriteria.date,
          value: SortingCriteria.date,
          child: Text('Date'),
        ),
        CheckedPopupMenuItem<SortingCriteria>(
          checked: store.state.sortingCriteria == SortingCriteria.distance,
          value: SortingCriteria.distance,
          child: Text('Distance'),
        ),
        CheckedPopupMenuItem<SortingCriteria>(
          checked: store.state.sortingCriteria == SortingCriteria.price,
          value: SortingCriteria.price,
          child: Text('Prix'),
        ),
      ],
    );
  }
}
