import 'package:comiko/pages/is_page.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class EventPage extends StatelessWidget implements IsPage {
  final Event event;
  final DateFormat dateTimeFormatter = DateFormat('d MMMM yyyy HH:mm');

  EventPage({@required this.event});

  @override
  Widget build(BuildContext context) {
    final _appBarHeight = 256.0;

    return Scaffold(
      primary: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: _appBarHeight,
            pinned: true,
            floating: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(event.artist),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    event.imageUri,
                    fit: BoxFit.cover,
                    height: _appBarHeight,
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
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
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
        ListTile(
          leading: Icon(Icons.slideshow),
          title: Text(event.name),
        ),
        ListTile(
          leading: Icon(Icons.date_range),
          title: Text("$startTime$endTime"),
        ),
        ListTile(
          leading: Icon(Icons.location_city),
          title: Text(event.place ?? ""),
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text(event.address ?? ""),
          subtitle: Text(event.city ?? ""),
        ),
        ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text("${event.price.toStringAsFixed(2)}\$"),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 32.0),
                    child: Icon(Icons.description),
                  ),
                  Text(
                    "Information",
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 72.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Text(
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
