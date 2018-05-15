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
  Widget build(BuildContext context) => GridTile(
        footer: _GridBottomBar(eventCardViewModel),
        child: _GridTileMainWidget(eventCardViewModel.event),
      );
}

class _GridBottomBar extends StatelessWidget {
  final EventCardViewModel viewModel;
  final DateFormat formatter = DateFormat('d MMMM yyyy HH:mm');

  _GridBottomBar(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return GestureDetector(
      onTap: () => navigateToEvent(viewModel.event, context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: FractionalOffset.centerLeft,
              child: Text(
                viewModel.event.artist,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: FractionalOffset.centerLeft,
              child: Text(
                viewModel.event.name,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ),
          GridTileBar(
            backgroundColor: Colors.black54,
            title: GridTileText(viewModel.event.place ?? ""),
            subtitle: GridTileText(formatter.format(viewModel.event.start)),
            trailing: GestureDetector(
              onTap: () =>
                  store.dispatch(ToggleFavoriteAction(viewModel.event)),
              child: Container(
                padding: EdgeInsets.all(22.0),
                color: Colors.transparent,
                child: Icon(
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
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => navigateToEvent(event, context),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              event.imageUri,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
