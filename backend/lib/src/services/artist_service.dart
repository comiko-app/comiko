import 'package:comiko_shared/models.dart' show Artist;
import 'base_service.dart';

abstract class ArtistService implements BaseService<Artist> {}

class FakeArtistService extends ArtistService {
  List<Artist> getAll() => [
        new Artist(
          name: "Martin Matte",
          biography: 'Martin se trouve cool.',
          image: "lib/assets/martin-matte1.jpg",
        ),
        new Artist(
          name: "Adib Alkhalidey",
          biography: "Me semble que c'est comme ça que ça se prononce",
          image: "lib/assets/adib-alkhalidey-1.jpg",
        ),
        new Artist(
          name: "Guillaume Wagner",
          biography: 'Aller chier.',
          image: "lib/assets/guillaume-wagner1.jpg",
        ),
        new Artist(
          name: "Jean-Marc Parent",
          biography: 'JM yo!.',
          image: "lib/assets/jean-marc-parent-v3.jpg",
        ),
      ];
}
