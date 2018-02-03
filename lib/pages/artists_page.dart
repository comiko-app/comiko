import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comiko/widgets/artist_card.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        stream: Firestore.instance
            .collection('artists')
            .where("deleted", isEqualTo: false)
            .orderBy('name', descending: false)
            .snapshots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');

          final artists = snapshot.data.documents
              .map((DocumentSnapshot document) =>
                  new Artist.fromJson(document.data))
              .toList();

          return new GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: artists.length,
            itemBuilder: (BuildContext context, int i) {
              precacheArtistImage(i, artists, context);

              return new ArtistCard(
                  new ArtistCardViewModel(artist: artists[i]));
            },
          );
        },
      ),
    );
  }

  void precacheArtistImage(int i, List<Artist> artists, BuildContext context) {
    final visibleImages = 6;
    var indexOfImageToCache = i + visibleImages;
    if (indexOfImageToCache >= artists.length) {
      return;
    }

    final imageProvider =
        new CachedNetworkImageProvider(artists[indexOfImageToCache].imageUrl);
    precacheImage(imageProvider, context);
  }
}
