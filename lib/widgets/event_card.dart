import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String photoUri;
  final String title;
  final String description;
  final String route;

  EventCard(this.title, this.description, this.photoUri, {this.route});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
      child: new GridTile(
        child: new Container(
            padding: const EdgeInsets.all(8.0),
            decoration: new BoxDecoration(color: Colors.black54),
            child: new Image.asset(photoUri)),
        footer: new GridTileBar(
          backgroundColor: Colors.black54,
          title: new _GridTitleText(title, false, null),
          subtitle: new Text(description),
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
        new Checkbox(
            value: value,
            onChanged: (_) => onChanged()),
      ]),
    );
  }
}