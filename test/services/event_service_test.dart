import 'dart:io';

import 'package:comiko/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

import 'package:comiko/services.dart';

main() {
  final service = new FakeEventService();
  test('Sorting by date works', () {
    final models = service.getAll();

    service.orderByDate(models);

    expect(models[0].artist, 'Adib Alkhalidey');
  });

  test('should load events from json file', () {
    final filePath =
    path.join(Directory.current.absolute.path, "lib/data/events.json");
    List<Map<String, dynamic>> jsonObject = JsonParser.parseFile(filePath);
    JsonEventService service = new JsonEventService();

    service.init(jsonObject);

    expect(service.events.isNotEmpty, true);
  });
}
