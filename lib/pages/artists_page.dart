import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comiko/pages/is_page.dart';
import 'package:comiko/widgets/artist_card.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';

class ArtistsPage extends StatelessWidget implements IsPage {
  @override
  Widget build(BuildContext context) => new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('artists')
            .where("deleted", isEqualTo: false)
            .orderBy('name', descending: false)
            .snapshots,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: const CircularProgressIndicator(),
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
                .map((document) => new Artist.fromJson(document.data))
                .map((a) => new ArtistCard(new ArtistCardViewModel(artist: a)))
                .toList(),
          );
        },
      );

  @override
  AppActionsFactory get actionsFactory => (context) => [];

  @override
  String get title => 'Artistes';
}
