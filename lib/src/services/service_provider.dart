import 'base_service.dart';
import 'event_service.dart';
import 'artist_service.dart';

typedef BaseService ServiceInstanciator();

class ServiceProvider {
  static final Map<Type, ServiceInstanciator> _providers = {
    EventService: () => new FakeEventService(),
    ArtistService: () => new FakeArtistService()
  };

  static Map<Type, BaseService> _cache = <Type, BaseService>{};

  static BaseService get(Type serviceType) {
    if (_cache.containsKey(serviceType)) {
      return _cache[serviceType];
    }
    return _cache[serviceType] = _providers[serviceType]();
  }
}
