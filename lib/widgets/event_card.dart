import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:comiko/app_state.dart';
import 'package:comiko/models.dart';

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

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('d MMMM yyyy HH:mm');

    return new GridTile(
      footer: new GestureDetector(
          onTap: () =>
              store.dispatch(new ToggleFavoriteAction(eventCardViewModel)),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: new Text(
                  eventCardViewModel.event.name,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              new GridTileBar(
                backgroundColor: Colors.black54,
                title: new _GridTitleText(eventCardViewModel.event.address),
                subtitle: new _GridTitleText(
                    formatter.format(eventCardViewModel.event.start)),
                trailing: new Container(
                  margin: new EdgeInsets.only(right: 8.0),
                  child: new Icon(
                    eventCardViewModel.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.asset(
            eventCardViewModel.event.image,
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
