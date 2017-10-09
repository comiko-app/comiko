import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:comiko_shared/models.dart';
import 'package:firebase_firestore/firebase_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArtistPage extends StatelessWidget {
  final String artistId;

  ArtistPage({@required this.artistId});

  @override
  Widget build(BuildContext context) {
    final double _appBarHeight = 256.0;
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('artists')
            .document(artistId)
            .snapshots,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }

          var artist = new Artist.fromJson(snapshot.data.data);

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
                        new Image.network(
                          artist.imageUrl,
                          fit: BoxFit.cover,
                          height: _appBarHeight,
                        ),
                        new Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(colors: <Color>[
                              Colors.black54,
                              Colors.transparent
                            ], begin: FractionalOffset.bottomCenter),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new SliverList(
                  delegate: new SliverChildListDelegate(
                    <Widget>[
                      artist.facebook != null
                          ? new ListTile(
                              leading: const Icon(FontAwesomeIcons.facebook),
                              title: const Text('Facebook'),
                              onTap: () {},
                            )
                          : null,
                      artist.twitter != null
                          ? new ListTile(
                              leading: const Icon(FontAwesomeIcons.twitter),
                              title: const Text('Twitter'),
                              onTap: () {},
                            )
                          : null,
                      artist.youtube != null
                          ? new ListTile(
                              leading: const Icon(FontAwesomeIcons.youtube),
                              title: const Text('YouTube'),
                              onTap: () {},
                            )
                          : null,
                      artist.website != null
                          ? new ListTile(
                              leading: const Icon(FontAwesomeIcons.chrome),
                              title: const Text('Website'),
                              onTap: () {},
                            )
                          : null,
                      new Divider(height: 32.0),
                      new Column(
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
                            child: new Text(artist.bio,
                                style: Theme.of(context).textTheme.body1),
                          ),
                        ],
                      )
                    ]..removeWhere((Widget w) => w == null),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
