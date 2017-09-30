import 'package:flutter_test/flutter_test.dart';

import 'package:comiko/services.dart';

main() {
  final service = ServiceProvider.get<EventService>(EventService);
  test('Sorting by date works', () {
    final models = service.getAll();

    service.orderByDate(models);

    expect(models[0].name, 'Adib Alkhalidey');
  });
}
