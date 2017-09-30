import 'package:flutter_test/flutter_test.dart';

import 'package:comiko/services.dart';
import 'package:comiko/models.dart';

main() {
  test('Service provider returns the correct service', () {
    final service = ServiceProvider.getByType(Event);

    expect(service, new isInstanceOf<BaseEventService>());
  });
}
