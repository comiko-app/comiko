import 'package:test/test.dart';
import 'package:comiko_backend/services.dart';

main() {
  test('Service provider returns the correct service', () {
    final service = ServiceProvider.get<EventService>(EventService);

    expect(service, new isInstanceOf<EventService>());
  });
}
