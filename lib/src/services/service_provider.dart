import 'package:comiko/models.dart';

import 'base_service.dart';
import 'events_service.dart';
import 'artists_service.dart';

typedef BaseService ServiceInstanciator();

class ServiceProvider {
  static final Map<Type, ServiceInstanciator> _providers = {
    Event: () => new FakeEventsService(),
    Artist: () => new FakeArtistService()
  };

  static Map<Type, BaseService> _cache = <Type, BaseService>{};

  static BaseService getByType(Type modelType) {
    if (_cache.containsKey(modelType)) {
      return _cache[modelType];
    }
    return _cache[modelType] = _providers[modelType]();
  }
}
