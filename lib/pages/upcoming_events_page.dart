import 'package:comiko/app_state.dart';
import 'package:comiko/widgets/event_card.dart';
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
      body: new GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: orientation == Orientation.portrait ? 1 : 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: store.state.events
            .map((EventCardViewModel vm) =>
                new StoreConnector<AppState, EventCardViewModel>(
                  converter: (_) => vm,
                  builder: (context, vm) => new EventCard(vm, store: store),
                ))
            .toList(),
      ),
    );
  }
}
