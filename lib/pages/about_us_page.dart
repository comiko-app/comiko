import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Qui sommes nous?'),
      ),
      body: new ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          new Container(
            child: new Image(
              image: const AssetImage('lib/assets/comiko_white.png'),
            ),
            height: 200.0,
            margin: const EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),
          ),
          new Container(
              child: new Text(
                """Comiko est une idée venue de quelques "geeks" d'humour, avec l'ambition de faciliter la vie de la communauté humoristique du Québec. \n\nLe but est de promouvoir l'humour et de donner une vitrine aux humoristes de la relève, ainsi qu'à ceux déjà établis. \n\nPar les fans d'humour, pour les fans d'humour.""",

            style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.left,
          )),
        ],
      ),
    );
  }
}
