import 'package:comiko/pages/is_page.dart';
import 'package:comiko/widgets/event_card.dart';
import 'package:comiko_backend/services.dart';
import 'package:comiko_shared/models.dart';

class AppState {
  static const String defaultCityFilter = "";
  static const double defaultPriceFilter = 100.0;
  static const int defaultDistanceFilter = 500;
  static const String defaultAppTitle = 'Comiko';
  static AppActionsFactory defaultAppActions = (_) => [];

  List<Event> events;
  Map<Event, bool> eventsFavoriteState = {};
  SortingCriteria sortingCriteria;
  String cityFilter;
  double priceFilter;
  int distanceFilter;
  String appTitle;
  AppActionsFactory appActions;
  EventService eventsService = ServiceProvider.get<EventService>(EventService);

  AppState.initial() {
    sortingCriteria = SortingCriteria.date;
    events = [];
    eventsFavoriteState = {};
    cityFilter = defaultCityFilter;
    priceFilter = defaultPriceFilter;
    distanceFilter = defaultDistanceFilter;
    appTitle = defaultAppTitle;
    appActions = defaultAppActions;
  }

  EventCardViewModel createViewModel(Event event) => new EventCardViewModel(
        event: event,
        isFavorite: eventsFavoriteState[event],
      );

  List<EventCardViewModel> getFavoriteEvents() => events
      .where((Event e) => eventsFavoriteState[e])
      .map((Event e) => new EventCardViewModel(event: e, isFavorite: true))
      .toList();

  void filterEventsWithActiveFilters() {
    var allEvent = eventsService.getAll();
    var sorted = eventsService.orderBy(allEvent, sort: sortingCriteria);

    if (cityFilter != null && cityFilter != "") {
      sorted = eventsService.filterBy(sorted,
          filter: FilteringCriteria.city, city: cityFilter);
    }

    if (priceFilter != null) {
      sorted = eventsService.filterBy(sorted,
          filter: FilteringCriteria.price, price: priceFilter);
    }

    if (distanceFilter != null) {
      sorted = eventsService.filterBy(sorted,
          filter: FilteringCriteria.distance, distance: distanceFilter);
    }

    events = sorted;
  }

  void resetFilters() {
    cityFilter = defaultCityFilter;
    priceFilter = defaultPriceFilter;
    distanceFilter = defaultDistanceFilter;
  }

  AppState._(
    this.events,
    this.sortingCriteria,
    this.eventsFavoriteState,
    this.cityFilter,
    this.priceFilter,
    this.distanceFilter,
    this.appTitle,
    this.appActions,
  );

  AppState clone() {
    var newState = new AppState._(
      new List.from(events),
      sortingCriteria,
      new Map.from(eventsFavoriteState),
      cityFilter,
      priceFilter,
      distanceFilter,
      appTitle,
      appActions,
    );

    return newState;
  }
}

class ToggleFavoriteAction extends IsAction {
  final Event event;

  ToggleFavoriteAction(this.event);

  @override
  AppState handle(AppState state) {
    var eventsFavoriteState = state.eventsFavoriteState[event];
    state.eventsFavoriteState[event] = !eventsFavoriteState;

    return state;
  }
}

class UpdateSortingCriteriaAction extends IsAction {
  final SortingCriteria criteria;

  UpdateSortingCriteriaAction(this.criteria);

  EventService eventService = ServiceProvider.get(EventService);

  @override
  AppState handle(AppState state) {
    state.sortingCriteria = criteria;
    state.events = eventService.orderBy(state.events, sort: criteria);

    return state;
  }
}

class UpdateCityFilterAction extends IsAction {
  final String value;
  EventService eventService = ServiceProvider.get(EventService);

  UpdateCityFilterAction(this.value);

  @override
  AppState handle(AppState state) {
    state.cityFilter = value;

    state.filterEventsWithActiveFilters();

    return state;
  }
}

class UpdatePriceFilterAction extends IsAction {
  final double value;
  EventService eventService = ServiceProvider.get(EventService);

  UpdatePriceFilterAction(this.value);

  @override
  AppState handle(AppState state) {
    state.priceFilter = value;

    state.filterEventsWithActiveFilters();

    return state;
  }
}

class UpdateDistanceFilterAction extends IsAction {
  final int value;
  EventService eventService = ServiceProvider.get(EventService);

  UpdateDistanceFilterAction(this.value);

  @override
  AppState handle(AppState state) {
    state.distanceFilter = value;

    state.filterEventsWithActiveFilters();

    return state;
  }
}

class FetchEventsAction extends IsAction {
  EventService eventService = ServiceProvider.get(EventService);

  @override
  AppState handle(AppState state) {
    state = state.clone();
    state.events = eventService.orderBy(
      eventService.getAll(),
      sort: state.sortingCriteria,
    );

    for (var event in state.events) {
      state.eventsFavoriteState[event] = false;
    }

    return state;
  }
}

class ResetFiltersAction extends IsAction {
  @override
  AppState handle(AppState state) {
    state = state.clone();
    state.resetFilters();
    state.filterEventsWithActiveFilters();

    return state;
  }
}

class PageChangedAction extends IsAction {
  final IsPage page;

  PageChangedAction(this.page);

  @override
  AppState handle(AppState state) {
    state = state.clone();
    state.appTitle = page.title;
    state.appActions = page.actionsFactory;

    return state;
  }
}

abstract class IsAction {
  AppState handle(AppState state);
}

AppState reducer<T extends IsAction>(AppState state, T action) {
  state = state.clone();
  state = action.handle(state);
  return state;
}
