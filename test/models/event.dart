import 'dart:convert';

import 'package:comiko/models.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('JSON deserialization works for event', () {
    var json = """
      {
        "id": 1,
        "name": "Eh lala..!",
        "artist": "Martin Matte",
        "place": "Théâtre du Palais municipal",
        "address": "",
        "city": "La baie",
        "date": "2018-04-12T00:00:00.000Z",
        "description": "Après sept ans d’absence sur scène, Martin Matte est enfin de retour avec un troisième spectacle solo. Intitulé Eh la la..! — le ton est donné — ce nouveau one-man-show voit le populaire humoriste revenir en force et en très grande forme. Toujours provocateur, mais non moins chaleureux et humain, l’auteur aguerri de la légendaire série Les beaux malaises réserve des émotions de toutes les couleurs. Fin observateur de ce qui l’entoure, il signe les textes avec le fidèle François Avard, bénéficiant aussi de la complicité du public alors qu’il rodait le contenu dans quelques villes québécoises. Place maintenant aux toutes nouvelles histoires du seul et unique Martin Matte, chroniques savoureuses de son époque, dans lesquelles un public toujours plus vaste se reconnaît immanquablement.",
        "image": "martin-matte1.jpg",
        "styles": ""
      }
  """;
    var jsonMap = JSON.decode(json);
    var model = new Event.fromJson(jsonMap);

    expect(model.name, 'Eh lala..!');
    expect(model.start.day, 12);
  });
}
