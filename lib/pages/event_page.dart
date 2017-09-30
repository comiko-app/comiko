import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _appBarHeight = 256.0;

    return new CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          expandedHeight: _appBarHeight,
          pinned: true,
          floating: false,
          snap: false,
          flexibleSpace: new FlexibleSpaceBar(
            title: const Text('Ali Connors'),
            background: new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new Image.asset(
                  'lib/assets/adib-alkhalidey-1.jpg',
                  fit: BoxFit.cover,
                  height: _appBarHeight,
                ),
                // This gradient ensures that the toolbar icons are distinct
                // against the background image.
                const DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: const LinearGradient(
                      begin: const FractionalOffset(0.5, 0.0),
                      end: const FractionalOffset(0.5, 0.30),
                      colors: const <Color>[
                        const Color(0x60000000),
                        const Color(0x00000000)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        new SliverList(
          delegate: new SliverChildListDelegate(<Widget>[
            new Container(
              height: 200.0,
              color: Colors.blue,
              margin: new EdgeInsets.all(8.0),
            ),
            new Container(
              height: 200.0,
              color: Colors.blue,
              margin: new EdgeInsets.all(8.0),
            ),
            new Container(
              height: 200.0,
              color: Colors.blue,
              margin: new EdgeInsets.all(8.0),
            ),
            new Container(
              height: 200.0,
              color: Colors.blue,
              margin: new EdgeInsets.all(8.0),
            ),
            new Container(
              height: 200.0,
              color: Colors.blue,
              margin: new EdgeInsets.all(8.0),
            ),
          ]),
        ),
      ],
    );
  }
}
