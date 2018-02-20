import 'package:comiko/app_state.dart';
import 'package:comiko/routing_assistant.dart';
import 'package:comiko/widgets/grid_tile_text.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

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

  const EventCard(
    this.eventCardViewModel,
  );

  @override
  Widget build(BuildContext context) => new GridTile(
        footer: new _GridBottomBar(eventCardViewModel),
        child: new _GridTileMainWidget(eventCardViewModel.event),
      );
}

class _GridBottomBar extends StatelessWidget {
  final EventCardViewModel viewModel;
  final DateFormat formatter = new DateFormat('d MMMM yyyy HH:mm');

  _GridBottomBar(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final store = new StoreProvider.of(context).store;
    return new GestureDetector(
      onTap: () => navigateToEvent(viewModel.event, context),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: new FittedBox(
              fit: BoxFit.scaleDown,
              alignment: FractionalOffset.centerLeft,
              child: new Text(
                viewModel.event.artist,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: new FittedBox(
              fit: BoxFit.scaleDown,
              alignment: FractionalOffset.centerLeft,
              child: new Text(
                viewModel.event.name,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ),
          new GridTileBar(
            backgroundColor: Colors.black54,
            title: new GridTileText(viewModel.event.place ?? ""),
            subtitle: new GridTileText(formatter.format(viewModel.event.start)),
            trailing: new GestureDetector(
              onTap: () =>
                  store.dispatch(new ToggleFavoriteAction(viewModel.event)),
              child: new Container(
                padding: const EdgeInsets.all(22.0),
                color: Colors.transparent,
                child: new Icon(
                  viewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridTileMainWidget extends StatelessWidget {
  final Event event;

  const _GridTileMainWidget(this.event);

  @override
  Widget build(BuildContext context) => new GestureDetector(
        onTap: () => navigateToEvent(event, context),
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image.asset(
              event.imageUri,
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

void navigateToEvent(Event event, BuildContext context) {
  Navigator.of(context).push(RoutingAssistant.eventPage(event));
}
