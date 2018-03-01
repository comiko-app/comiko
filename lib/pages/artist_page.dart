import 'package:comiko/pages/is_page.dart';
import 'package:comiko/widgets/artist_image.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistPage extends StatelessWidget implements IsPage {
  final Artist artist;

  const ArtistPage({@required this.artist});

  @override
  Widget build(BuildContext context) {
    final _appBarHeight = 256.0;

    return Scaffold(
      primary: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: true,
            floating: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(artist.name),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ArtistImage(
                    url: artist.imageUrl,
                    height: _appBarHeight,
                  ),
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
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                socialWidgets(artist, context),
                bioWidgets(context, artist),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  AppActionsFactory get actionsFactory => (context) => [];

  @override
  String get title => artist.name;
}

Column bioWidgets(BuildContext context, Artist artist) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.info),
          title: Text(
            'Biographie',
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 72.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Text(artist.bio, style: Theme.of(context).textTheme.body1),
        ),
      ],
    );

Widget socialWidgets(Artist artist, BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SocialIcon(
        url: artist.facebook,
        leadingIcon: FontAwesomeIcons.facebook,
      ),
      SocialIcon(
        url: artist.twitter,
        leadingIcon: FontAwesomeIcons.twitter,
      ),
      SocialIcon(
        url: artist.youtube,
        leadingIcon: FontAwesomeIcons.youtube,
      ),
      SocialIcon(
        url: artist.website,
        leadingIcon: FontAwesomeIcons.chrome,
      ),
    ].where((w) => w is! Container).toList());

class SocialIcon extends StatelessWidget {
  final String url;
  final IconData leadingIcon;

  const SocialIcon({
    @required this.url,
    @required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) => url == null
      ? Container()
      : IconButton(
          icon: Icon(leadingIcon),
          onPressed: () => launch(url),
        );
}
