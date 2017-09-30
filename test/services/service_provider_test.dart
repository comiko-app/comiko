import 'package:flutter_test/flutter_test.dart';

import 'package:comiko/services.dart';

main() {
  test('Service provider returns the correct service', () {
    final service = ServiceProvider.get<EventService>(EventService);

    expect(service, new isInstanceOf<EventService>());
  });
}
