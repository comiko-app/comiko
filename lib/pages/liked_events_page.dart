import 'package:comiko/app_state.dart';
import 'package:comiko/pages/is_page.dart';
import 'package:comiko/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LikedEventsPage extends StatelessWidget implements IsPage {
  const LikedEventsPage();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return new StoreConnector<AppState, List<EventCardViewModel>>(
      converter: (store) => store.state.getFavoriteEvents(),
      builder: (context, vms) => new GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 1 : 3,
            padding: const EdgeInsets.all(8.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: vms.map((vm) => new EventCard(vm)).toList(),
          ),
    );
  }

  @override
  String get title => 'Favoris';

  @override
  AppActionsFactory get actionsFactory => (context) => [];
}
