import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comiko/pages/is_page.dart';
import 'package:comiko/widgets/artist_card.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';

class ArtistsPage extends StatelessWidget implements IsPage {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('artists')
          .where("deleted", isEqualTo: false)
          .orderBy('name', descending: false)
          .snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }

        return new GridView.count(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          children: snapshot.data.documents
              .map((DocumentSnapshot document) =>
                  new Artist.fromJson(document.data))
              .map((Artist a) =>
                  new ArtistCard(new ArtistCardViewModel(artist: a)))
              .toList(),
        );
      },
    );
  }

  @override
  AppActionsFactory get actionsFactory => (BuildContext context) => [];

  @override
  String get title => 'Artistes';
}
