import 'package:flutter/material.dart';
import 'package:comiko/widgets/event_card.dart';

class MainMenu extends StatelessWidget {
  MainMenu(this.menuContent);

  final List<EventCard> menuContent;

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      body: new GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: menuContent,
      ),
    );
  }
}
