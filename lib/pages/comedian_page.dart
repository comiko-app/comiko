import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {

  List<MenuCard> MenuContent;

  MainMenu(List<MenuCard> menuContent){
    MenuContent = menuContent;
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      body: new GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: MenuContent,
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String photoUri;
  final String title;
  final String description;
  final String route;

  MenuCard(this.title, this.description, this.photoUri, {this.route});

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
          title: new _GridTitleText(title),
          subtitle: new Text(description),
        ),
      ),
    );
  }
}

class _GridTitleText extends StatelessWidget {
  _GridTitleText(this.text);

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