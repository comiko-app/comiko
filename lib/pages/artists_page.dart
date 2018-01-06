import 'package:comiko/widgets/artist_card.dart';
import 'package:comiko_shared/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('artists').snapshots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return new GridView.count(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 4,
            padding: const EdgeInsets.all(8.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return new ArtistCard(
                new ArtistCardViewModel(
                  artist: new Artist.fromJson(document.data),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
