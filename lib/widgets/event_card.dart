import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:comiko/src/models/event.dart';

class EventCardViewModel {
  final Event event;
  final bool isFavorite;

  EventCardViewModel({
    @required this.event,
    this.isFavorite = false,
  });
}

class EventCard extends StatelessWidget {
  final EventCardViewModel eventCardViewModel;

  EventCard(this.eventCardViewModel);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {},
      child: new GridTile(
        child: new Container(
            padding: const EdgeInsets.all(0.0),
            decoration: new BoxDecoration(color: Colors.black54),
            child: new Image.asset(
              eventCardViewModel.event.image,
              fit: BoxFit.cover,
            )),
        footer: new GridTileBar(
          backgroundColor: Colors.black54,
          title: new _GridTitleText(eventCardViewModel.event.name,
              eventCardViewModel.isFavorite, null),
          subtitle: new Text(eventCardViewModel.event.description),
        ),
      ),
    );
  }
}

class _GridTitleText extends StatelessWidget {
  final bool value;
  final void Function() onChanged;

  _GridTitleText(this.text, this.value, this.onChanged);

  final String text;

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.scaleDown,
      alignment: FractionalOffset.centerLeft,
      child: new Row(children: <Widget>[
        new Text(text),
        new Checkbox(value: value, onChanged: (_) => onChanged()),
      ]),
    );
  }
}
