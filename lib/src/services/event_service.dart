import 'package:comiko/models.dart' show Event;
import 'base_service.dart';

abstract class EventService implements BaseService<Event> {
  void orderByDate(final List<Event> models) =>
      models.sort((a, b) => a.start.compareTo(b.start));
}

class FakeEventService extends EventService {
  List<Event> getAll() => [
        new Event(
          name: "Eh lala..!",
          artist: "Martin Matte",
          place: "Théâtre Palace Arvida",
          address: "1900 Boulevard Mellon, Jonquière, QC G7S 3H4",
          description: "Bacon ipsum dolor amet kevin short ribs kielbasa filet mignon sirloin jerky. Turkey corned beef ham t-bone bresaola meatloaf. Brisket porchetta tongue rump, turkey tri-tip pork loin t-bone. Tongue t-bone kevin filet mignon pork. Sausage chuck chicken, salami burgdoggen prosciutto corned beef shoulder kielbasa alcatra beef ribs leberkas.",
          price: 49.75,
          start: new DateTime(2017, 11, 15, 23),
          image: "lib/assets/martin-matte1.jpg",
        ),
        new Event(
          name: "Eh lala..!",
          artist: "Adib Alkhalidey",
          place: "Théâtre Banque Nationale",
          start: new DateTime(2017, 11, 15, 14),
          image: "lib/assets/adib-alkhalidey-1.jpg",
        ),
        new Event(
          name: "Eh lala..!",
          artist: "Guillaume Wagner",
          place: "Théâtre du Palais Municipal",
          start: new DateTime(2017, 11, 15, 15),
          image: "lib/assets/guillaume-wagner1.jpg",
        ),
        new Event(
          name: "Eh lala..!",
          artist: "Jean-Marc Parent",
          place: "Côté-Cour",
          start: new DateTime(2017, 11, 15, 29),
          image: "lib/assets/jean-marc-parent-v3.jpg",
        ),
      ];
}
