import 'package:comiko/routing_assistant.dart';
import 'package:comiko/widgets/artist_image.dart';
import 'package:comiko/widgets/grid_tile_text.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ArtistCardViewModel {
  final Artist artist;
  bool isFavorite;

  ArtistCardViewModel({
    @required this.artist,
    this.isFavorite = false,
  });
}

class ArtistCard extends StatelessWidget {
  final ArtistCardViewModel artistCardViewModel;

  ArtistCard(this.artistCardViewModel);

  void navigateToArtist(BuildContext context) {
    Navigator.push(
        context, RoutingAssistant.artistPage(artistCardViewModel.artist));
  }

  @override
  Widget build(BuildContext context) {
    return new GridTile(
      footer: new GestureDetector(
        onTap: () => navigateToArtist(context),
        child: new GridTileBar(
          backgroundColor: Colors.black54,
          title: new GridTileText(artistCardViewModel.artist.name),
          trailing: new GestureDetector(
            onTap: () => null,
            child: new Container(
              padding: const EdgeInsets.only(right: 8.0),
              color: Colors.transparent,
              child: new Icon(
                artistCardViewModel.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      child: new GestureDetector(
        onTap: () => navigateToArtist(context),
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new ArtistImage(artistCardViewModel.artist.imageUrl),
            new Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: <Color>[Colors.black54, Colors.transparent],
                    begin: FractionalOffset.bottomCenter),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
