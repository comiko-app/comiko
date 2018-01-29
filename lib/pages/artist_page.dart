import 'package:comiko/widgets/artist_image.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistPage extends StatelessWidget {
  final Artist artist;

  ArtistPage({@required this.artist});

  @override
  Widget build(BuildContext context) {
    final double _appBarHeight = 256.0;

    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: true,
            floating: false,
            snap: false,
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text(artist.name),
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new ArtistImage(artist.imageUrl, height: _appBarHeight),
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
          ),
          new SliverList(
            delegate:
                new SliverChildListDelegate(socialWidgets(artist, context)),
          ),
        ],
      ),
    );
  }
}

Column bioWidgets(BuildContext context, Artist artist) => new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ListTile(
          leading: const Icon(Icons.info),
          title: new Text(
            'Biographie',
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(
            left: 72.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: new Text(artist.bio, style: Theme.of(context).textTheme.body1),
        ),
      ],
    );

List<Widget> socialWidgets(Artist artist, BuildContext context) => [
      artist.facebook != null
          ? new ListTile(
              leading: const Icon(FontAwesomeIcons.facebook),
              title: new Text(artist.facebookHandle),
              onTap: () => launch(artist.facebook),
            )
          : null,
      artist.twitter != null
          ? new ListTile(
              leading: const Icon(FontAwesomeIcons.twitter),
              title: new Text(artist.twitterHandle),
              onTap: () => launch(artist.twitter),
            )
          : null,
      artist.youtube != null
          ? new ListTile(
              leading: const Icon(FontAwesomeIcons.youtube),
              title: new Text(artist.youtubeHandle),
              onTap: () => launch(artist.youtube),
            )
          : null,
      artist.website != null
          ? new ListTile(
              leading: const Icon(FontAwesomeIcons.chrome),
              title: new Text(artist.websiteShort),
              onTap: () => launch(artist.website),
            )
          : null,
      new Divider(height: 32.0),
      bioWidgets(context, artist)
    ].where((Widget w) => w != null).toList();
