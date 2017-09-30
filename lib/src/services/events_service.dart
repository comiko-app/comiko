import 'package:comiko/models.dart';

abstract class EventsService {
  List<Event> getAll();
}

class FakeEventsService extends EventsService {
  List<Event> getAll() => [
        new Event(
          name: "Martin",
          description: "Much fun",
          start: new DateTime(2017, 11, 15),
          image: "lib/assets/martin-matte1.jpg",
        ),
        new Event(
          name: "Martin",
          description: "Much fun",
          start: new DateTime(2017, 11, 15),
          image: "lib/assets/martin-matte1.jpg",
        ),
        new Event(
          name: "Martin",
          description: "Much fun",
          start: new DateTime(2017, 11, 15),
          image: "lib/assets/martin-matte1.jpg",
        ),
        new Event(
          name: "Martin",
          description: "Much fun",
          start: new DateTime(2017, 11, 15),
          image: "lib/assets/martin-matte1.jpg",
        ),
      ];
}
