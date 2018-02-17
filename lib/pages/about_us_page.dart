import 'package:comiko/pages/is_page.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget implements IsPage {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
        new Container(
          child: new Image(
            image: const AssetImage('lib/assets/comiko_white.png'),
          ),
          height: 200.0,
          margin: const EdgeInsets.only(
            top: 20.0,
          ),
        ),
        new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createParagraphWidget(
                "Comiko est une idée venue de quelques \"geeks\" d'humour, avec"
                    " l'ambition de faciliter la vie de la communauté "
                    "humoristique du Québec.",
                context,
              ),
              createParagraphWidget(
                "Le but est de promouvoir l'humour et de donner une vitrine aux"
                    " humoristes de la relève, ainsi qu'à ceux déjà établis.",
                context,
              ),
              createParagraphWidget(
                  "Par les fans d'humour, pour les fans d'humour.", context),
            ],
          ),
        ),
      ],
    );
  }

  @override
  AppActionsFactory get actionsFactory => (BuildContext context) => [];

  @override
  String get title => "Qui sommes-nous?";

  Widget createParagraphWidget(String text, context) {
    final textStyle = Theme.of(context).textTheme.subhead;

    return new Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: new Text(
        text,
        style: textStyle,
      ),
    );
  }
}
