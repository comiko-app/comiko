import 'dart:io';

import 'package:comiko/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

main() {
  test('can parse json', () {
    final filePath =
        path.join(Directory.current.absolute.path, "test/utils/test.json");
    List<Map<String, dynamic>> jsonObject = JsonParser.parseFile(filePath);

    expect(jsonObject, new isInstanceOf<List>());
  });
}
