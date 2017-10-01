import 'package:comiko/src/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class EventPage extends StatelessWidget {
  final Event event;

  EventPage({@required this.event});

  @override
  Widget build(BuildContext context) {
    final double _appBarHeight = 256.0;
    final DateFormat dateTimeFormatter = new DateFormat('d MMMM yyyy HH:mm');

    String startTime = dateTimeFormatter.format(event.start);
    String endTime = event.end == null
        ? ""
        : " - ${dateTimeFormatter.format(
        event.end)}";

    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
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
              <Widget>[
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
                new Divider(height: 32.0),
                new ListTile(
                  leading: const Icon(Icons.add_location),
                  title: new Text(event.address ?? ""),
                  subtitle: new Text(event.city ?? ""),
                ),
                new ListTile(
                  leading: const Icon(Icons.monetization_on),
                  title: new Text("${event.price.toStringAsFixed(2)}\$"),
                ),
                new Divider(height: 32.0),
                new Container(
                  margin: new EdgeInsets.all(16.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.only(right: 32.0),
                        child: new Icon(Icons.description),
                      ),
                      new Text(
                        "Information",
                        style: Theme
                            .of(context)
                            .textTheme
                            .title,
                      ),
                    ],
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.only(left: 72.0, right: 16.0),
                  child: new Text(
                    event.description ?? "",
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead,
                  ),
                ),
                new Container(
                  height: 64.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
