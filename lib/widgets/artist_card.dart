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

  const ArtistCard(this.artistCardViewModel);

  void navigateToArtist(BuildContext context) {
    Navigator.push(
        context, RoutingAssistant.artistPage(artistCardViewModel.artist));
  }

  @override
  Widget build(BuildContext context) => GridTile(
        footer: GestureDetector(
          onTap: () => navigateToArtist(context),
          child: GridTileBar(
            backgroundColor: Colors.black54,
            title: GridTileText(artistCardViewModel.artist.name),
            trailing: GestureDetector(
              onTap: () => null,
              child: Container(
                padding: EdgeInsets.only(right: 8.0),
                color: Colors.transparent,
                child: Icon(
                  artistCardViewModel.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () => navigateToArtist(context),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ArtistImage(url: artistCardViewModel.artist.imageUrl),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.black54, Colors.transparent],
                      begin: FractionalOffset.bottomCenter),
                ),
              ),
            ],
          ),
        ),
      );
}
