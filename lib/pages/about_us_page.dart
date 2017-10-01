import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
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
            """Bacon ipsum dolor amet t-bone andouille meatball filet mignon, chicken bacon leberkas. Capicola shoulder hamburger short ribs, shank pork belly pastrami burgdoggen drumstick bresaola strip steak leberkas corned beef cow venison. Filet mignon andouille ground round picanha brisket. Filet mignon turducken jerky t-bone, corned beef capicola landjaeger rump turkey pork chop porchetta tongue kevin short ribs ham.

Ribeye cow picanha, doner pig strip steak turkey. Pastrami pig beef ribs landjaeger kevin strip steak. Pastrami doner rump corned beef pork chop turkey shoulder. Drumstick shankle boudin hamburger ball tip pork chop chuck. Tongue brisket pork belly beef ribs pig spare ribs. Tri-tip rump venison ball tip cow biltong shoulder ham hock.""",
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.justify,
          )),
        ],
      ),
    );
  }
}
