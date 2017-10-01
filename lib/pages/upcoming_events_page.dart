import 'package:comiko/app_state.dart';
import 'package:comiko/models.dart';
import 'package:comiko/widgets/event_card.dart';
import 'package:comiko/widgets/filter_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class UpcomingEventsPage extends StatelessWidget {
  final Store<AppState> store;

  UpcomingEventsPage({@required this.store});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('À venir'),
        actions: [
          new FilterPopupMenu(store: store),
        ],
      ),
      body: new StoreConnector<AppState, List<EventCardViewModel>>(
        converter: (store) => store.state.events
            .map((Event e) => store.state.createViewModel(e))
            .toList(),
        builder: (context, vms) => new GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 1 : 3,
              padding: const EdgeInsets.all(8.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: vms
                  .map((EventCardViewModel vm) =>
                      new EventCard(vm, store: store))
                  .toList(),
            ),
      ),
    );
  }
}
