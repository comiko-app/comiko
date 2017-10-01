import 'package:comiko/app_state.dart';
import 'package:comiko/models.dart';
import 'package:comiko/routing_assistant.dart';
import 'package:comiko/src/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class EventCardViewModel {
  final Event event;
  bool isFavorite;

  EventCardViewModel({
    @required this.event,
    this.isFavorite = false,
  });
}

class EventCard extends StatelessWidget {
  final EventCardViewModel eventCardViewModel;
  final Store<AppState> store;

  EventCard(this.eventCardViewModel, {
    @required this.store,
  });

  void navigateToEvent(BuildContext context) {
    Navigator
        .of(context)
        .push(RoutingAssistant.eventPage(eventCardViewModel.event));
  }

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('d MMMM yyyy HH:mm');

    return new GridTile(
      footer: new GestureDetector(
        onTap: () => navigateToEvent(context),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: new FittedBox(
                fit: BoxFit.scaleDown,
                alignment: FractionalOffset.centerLeft,
                child: new Text(
                  eventCardViewModel.event.artist,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: new FittedBox(
                fit: BoxFit.scaleDown,
                alignment: FractionalOffset.centerLeft,
                child: new Text(
                  eventCardViewModel.event.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead,
                ),
              ),
            ),
            new GridTileBar(
              backgroundColor: Colors.black54,
              title: new _GridTitleText(eventCardViewModel.event.place ?? ""),
              subtitle: new _GridTitleText(
                  formatter.format(eventCardViewModel.event.start)),
              trailing: new GestureDetector(
                onTap: () =>
                    store.dispatch(
                        new ToggleFavoriteAction(eventCardViewModel.event)),
                child: new Container(
                  padding: const EdgeInsets.all(22.0),
                  color: Colors.transparent,
                  child: new Icon(
                    eventCardViewModel.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      child: new GestureDetector(
        onTap: () => navigateToEvent(context),
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image.asset(
              eventCardViewModel.event.imageUri,
              fit: BoxFit.cover,
            ),
            new Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: <Color>[Colors.black54, Colors.transparent],
                    begin: FractionalOffset.bottomCenter),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.scaleDown,
      alignment: FractionalOffset.centerLeft,
      child: new Text(text),
    );
  }
}
