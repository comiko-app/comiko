import 'package:flutter/material.dart';

class ArtistsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new Container(
          margin: new EdgeInsets.all(12.0),
          child: new Image(
            image: const AssetImage('lib/assets/comiko_logo.png'),
            fit: BoxFit.contain,
          ),
        ),
        title: new Text("Artistes"),
      ),
      body: new Center(
        child: new Text(
          "Bientôt disponible",
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    );
  }
}
