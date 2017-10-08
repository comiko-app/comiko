import 'package:comiko/widgets/artist_card.dart';
import 'package:comiko_shared/models.dart';
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
      body: new GridView.count(
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 3,
        padding: const EdgeInsets.all(8.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: <Widget>[
          new ArtistCard(
            new ArtistCardViewModel(
              artist: new Artist(
                  name: "Mike Ward",
                  image:
                      "http://www.repertoiredesartistesquebecois.org/public/membres/2395.jpg"),
            ),
          ),
        ],
      ),
    );
  }
}
