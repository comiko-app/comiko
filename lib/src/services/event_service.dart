import 'package:comiko/models.dart';

import 'base_service.dart';

int _orderEventByDate(final Event a, final Event b) =>
    a.start.compareTo(b.start);

// TODO implement distance sort
int _orderEventByDistance(final Event a, final Event b) => 0;

int _orderEventByPrice(final Event a, final Event b) =>
    a.price.compareTo(b.price);

abstract class EventService implements BaseService<Event> {
  static const Map<SortingCriteria, Comparator> _sortComparators =
      const <SortingCriteria, Comparator>{
    SortingCriteria.date: _orderEventByDate,
    SortingCriteria.distance: _orderEventByDistance,
    SortingCriteria.price: _orderEventByPrice
  };

  List<Event> orderBy(
    final List<Event> models, {
    final SortingCriteria sort = SortingCriteria.date,
    final bool asc = true,
  }) {
    final sorted = new List<Event>.from(models);
    sorted.sort(EventService._sortComparators[sort]);
    return asc ? sorted : sorted.reversed.toList();
  }

  List<Event> filterBy(
    final List<Event> models, {
    final FilteringCriteria sort = FilteringCriteria.distance,
    final int distance,
    final DateTime from,
    final DateTime to,
    final String city,
    final double price,
  }) {
    // TODO clean this
    switch (sort) {
      case FilteringCriteria.distance:
        // TODO implement distance filtering
        return models;
      case FilteringCriteria.date:
        return models
            .where((final Event event) =>
                event.start.isBefore(to) && event.start.isAfter(from))
            .toList();
      case FilteringCriteria.city:
        return models
            .where((final Event event) =>
        event.city.toLowerCase() == city.toLowerCase())
            .toList();
      case FilteringCriteria.price:
        return models
            .where((final Event event) => event.price <= price)
            .toList();
      default:
        break;
    }
    return models;
  }
}

class JsonEventService extends EventService {
  List<Event> events = new List<Event>();

  init(List<Map<String, dynamic>> eventJson) {
    events = eventJson.map((e) => new Event.fromJson(e)).toList();
  }

  List<Event> getAll() => events;
}
