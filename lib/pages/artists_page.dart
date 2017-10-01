import 'package:flutter/material.dart';

class ArtistsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
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
