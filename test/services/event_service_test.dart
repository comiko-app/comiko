import 'package:comiko/services.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final service = new FakeEventService();
  test('Sorting by date works', () {
    final models = service.getAll();

    service.orderByDate(models);

    expect(models[0].artist, 'Adib Alkhalidey');
  });

  test('should init events from map', () {
    List<Map<String, dynamic>> jsonObject = [
      {"name": "chien", "artist": "Com Truise"},
      {"name": "Chat", "artist": "Bruno Pierre"}
    ];
    JsonEventService service = new JsonEventService();

    service.init(jsonObject);

    expect(service.events.isNotEmpty, true);
  });
}
