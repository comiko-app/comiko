import 'package:comiko/app_state.dart';
import 'package:comiko/pages/is_page.dart';
import 'package:comiko/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';

class LikedEventsPage extends StatelessWidget implements IsPage {
  const LikedEventsPage();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return StoreConnector<AppState, List<EventCardViewModel>>(
      converter: (Store<AppState> store) => store.state.getFavoriteEvents(),
      builder: (context, vms) => vms.isEmpty
          ? Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.frown,
                      size: 72.0,
                    ),
                  ),
                  Text('Aucun évènement ajouté aux favoris'),
                ],
              ),
            )
          : GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 1 : 3,
              padding: EdgeInsets.all(8.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: vms.map((vm) => EventCard(vm)).toList(),
            ),
    );
  }

  @override
  String get title => 'Favoris';

  @override
  AppActionsFactory get actionsFactory => (context) => [];
}
