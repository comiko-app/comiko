import 'package:comiko/pages/is_page.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class EventPage extends StatelessWidget implements IsPage {
  final Event event;
  final DateFormat dateTimeFormatter = new DateFormat('d MMMM yyyy HH:mm');

  EventPage({@required this.event});

  @override
  Widget build(BuildContext context) {
    final _appBarHeight = 256.0;

    return new Scaffold(
      primary: false,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: _appBarHeight,
            pinned: true,
            floating: false,
            snap: false,
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text(event.artist),
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Image.asset(
                    event.imageUri,
                    fit: BoxFit.cover,
                    height: _appBarHeight,
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
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(
              eventDetails(event, context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> eventDetails(Event event, BuildContext context) {
    final startTime = dateTimeFormatter.format(event.start);
    final endTime = event.end == null
        ? ""
        : " - ${dateTimeFormatter.format(
        event.end)}";

    return ListTile.divideTiles(
      context: context,
      tiles: [
        new ListTile(
          leading: const Icon(Icons.slideshow),
          title: new Text(event.name),
        ),
        new ListTile(
          leading: const Icon(Icons.date_range),
          title: new Text("$startTime$endTime"),
        ),
        new ListTile(
          leading: const Icon(Icons.location_city),
          title: new Text(event.place ?? ""),
        ),
        new ListTile(
          leading: const Icon(Icons.location_on),
          title: new Text(event.address ?? ""),
          subtitle: new Text(event.city ?? ""),
        ),
        new ListTile(
          leading: const Icon(Icons.monetization_on),
          title: new Text("${event.price.toStringAsFixed(2)}\$"),
        ),
        new Column(
          children: [
            new Container(
              margin: const EdgeInsets.all(16.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(right: 32.0),
                    child: new Icon(Icons.description),
                  ),
                  new Text(
                    "Information",
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(
                left: 72.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: new Text(
                event.description ?? "",
                style: Theme.of(context).textTheme.subhead,
              ),
            )
          ],
        ),
      ],
    ).toList();
  }

  @override
  String get title => event.artist;

  @override
  AppActionsFactory get actionsFactory => (context) => [];
}
