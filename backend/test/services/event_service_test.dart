import 'package:comiko_shared/models.dart';
import 'package:comiko_backend/services.dart';
import 'package:test/test.dart';

class FakeEventService extends EventService {
  List<Event> getAll({
    final SortingCriteria sort = SortingCriteria.date,
    final bool asc = true,
  }) =>
      [
        new Event(
          name: "Eh lala..!",
          artist: "Martin Matte",
          place: "Théâtre Palace Arvida",
          address: "1900 Boulevard Mellon, Jonquière, QC G7S 3H4",
          description:
              "Bacon ipsum dolor amet kevin short ribs kielbasa filet mignon sirloin jerky. Turkey corned beef ham t-bone bresaola meatloaf. Brisket porchetta tongue rump, turkey tri-tip pork loin t-bone. Tongue t-bone kevin filet mignon pork. Sausage chuck chicken, salami burgdoggen prosciutto corned beef shoulder kielbasa alcatra beef ribs leberkas.",
          price: 49.75,
          start: new DateTime(2017, 11, 15, 15),
          image: "lib/assets/martin-matte1.jpg",
        ),
        new Event(
          name: "Eh lala..!",
          artist: "Adib Alkhalidey",
          place: "Théâtre Banque Nationale",
          start: new DateTime(2017, 11, 15, 23),
          image: "lib/assets/adib-alkhalidey-1.jpg",
        ),
        new Event(
          name: "Eh lala..!",
          artist: "Guillaume Wagner",
          place: "Théâtre du Palais Municipal",
          start: new DateTime(2017, 11, 15, 14),
          image: "lib/assets/guillaume-wagner1.jpg",
        ),
        new Event(
          name: "Eh lala..!",
          artist: "Jean-Marc Parent",
          place: "Côté-Cour",
          start: new DateTime(2017, 11, 15, 20),
          image: "lib/assets/jean-marc-parent-v3.jpg",
        )
      ];
}

main() {
  final service = new FakeEventService();
  test('Sorting by asc date works', () {
    final models = service.getAll();

    final sorted = service.orderBy(models);

    expect(sorted[0].artist, 'Guillaume Wagner');
  });

  test('Sorting by desc date works', () {
    final models = service.getAll();

    final sorted = service.orderBy(models, asc: false);

    expect(sorted[0].artist, 'Adib Alkhalidey');
  });

  test('Filtering by date works', () {
    final models = service.getAll();
    final from = new DateTime(2017, 11, 15, 19);

    final filtered = service.filterBy(
      models,
      filter: FilteringCriteria.date,
      from: from,
      to: from.add(new Duration(hours: 2)),
    );

    expect(filtered[0].artist, 'Jean-Marc Parent');
  });

  test('should init events from map', () {
    List<Map<String, dynamic>> jsonObject = [
      {"name": "chien", "artist": "Com Truise"},
      {"name": "Chat", "artist": "Bruno Pierre"}
    ];
    JsonEventService service = new JsonEventService();

    service.init(jsonObject);

    expect(service.getAll().isNotEmpty, true);
  });
}
