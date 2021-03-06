import 'package:comiko/pages/is_page.dart';
import 'package:comiko/widgets/event_card.dart';
import 'package:comiko_backend/services.dart';
import 'package:comiko_shared/models.dart';
import 'package:redux/redux.dart';

class AppState {
  static const String defaultCityFilter = '';
  static const double defaultPriceFilter = 100.0;
  static const int defaultDistanceFilter = 500;
  static const String defaultAppTitle = 'Comiko';
  static const int defaultPageIndex = 0;
  static AppActionsFactory defaultAppActions = (_) => [];

  List<Event> events;
  Map<Event, bool> eventsFavoriteState = {};
  SortingCriteria sortingCriteria;
  String cityFilter;
  double priceFilter;
  int distanceFilter;
  String appTitle;
  int currentPageIndex;
  AppActionsFactory appActions;
  EventService eventsService = ServiceProvider.get<EventService>(EventService);

  AppState._(
    this.events,
    this.sortingCriteria,
    this.eventsFavoriteState,
    this.cityFilter,
    this.priceFilter,
    this.distanceFilter,
    this.appTitle,
    this.appActions,
    this.currentPageIndex,
  );

  AppState.initial() {
    sortingCriteria = SortingCriteria.date;
    events = [];
    eventsFavoriteState = {};
    cityFilter = defaultCityFilter;
    priceFilter = defaultPriceFilter;
    distanceFilter = defaultDistanceFilter;
    appTitle = defaultAppTitle;
    appActions = defaultAppActions;
    currentPageIndex = defaultPageIndex;
  }

  EventCardViewModel createViewModel(Event event) => EventCardViewModel(
        event: event,
        isFavorite: eventsFavoriteState[event],
      );

  List<EventCardViewModel> getFavoriteEvents() => events
      .where((e) => eventsFavoriteState[e])
      .map((e) => EventCardViewModel(event: e, isFavorite: true))
      .toList();

  void filterEventsWithActiveFilters() {
    final allEvents = eventsService.getAll();
    var sorted = eventsService.orderBy(allEvents, sort: sortingCriteria);

    if (cityFilter != null && cityFilter != '') {
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

  AppState clone() {
    final newState = AppState._(
      List.from(events),
      sortingCriteria,
      Map.from(eventsFavoriteState),
      cityFilter,
      priceFilter,
      distanceFilter,
      appTitle,
      appActions,
      currentPageIndex,
    );

    return newState;
  }
}

class ToggleFavoriteAction extends IsAction {
  final Event event;

  ToggleFavoriteAction(this.event);

  @override
  AppState handle(AppState state) {
    final eventsFavoriteState = state.eventsFavoriteState[event];
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
    state
      ..sortingCriteria = criteria
      ..events = eventService.orderBy(state.events, sort: criteria);

    return state;
  }
}

class UpdateCityFilterAction extends IsAction {
  final String value;
  EventService eventService = ServiceProvider.get(EventService);

  UpdateCityFilterAction(this.value);

  @override
  AppState handle(AppState state) {
    state
      ..cityFilter = value
      ..filterEventsWithActiveFilters();

    return state;
  }
}

class UpdatePriceFilterAction extends IsAction {
  final double value;
  EventService eventService = ServiceProvider.get(EventService);

  UpdatePriceFilterAction(this.value);

  @override
  AppState handle(AppState state) {
    state
      ..priceFilter = value
      ..filterEventsWithActiveFilters();

    return state;
  }
}

class UpdateDistanceFilterAction extends IsAction {
  final int value;
  EventService eventService = ServiceProvider.get(EventService);

  UpdateDistanceFilterAction(this.value);

  @override
  AppState handle(AppState state) {
    state
      ..distanceFilter = value
      ..filterEventsWithActiveFilters();

    return state;
  }
}

class FetchEventsAction extends IsAction {
  EventService eventService = ServiceProvider.get(EventService);

  @override
  AppState handle(AppState state) {
    final newState = state.clone()
      ..events = eventService.orderBy(eventService.getAll(),
          sort: state.sortingCriteria);

    for (var event in newState.events) {
      newState.eventsFavoriteState[event] = false;
    }

    return newState;
  }
}

class ResetFiltersAction extends IsAction {
  @override
  AppState handle(AppState state) {
    final newState = state.clone()
      ..resetFilters()
      ..filterEventsWithActiveFilters();

    return newState;
  }
}

class PageChangedAction extends IsAction {
  final IsPage page;
  final int pageIndex;

  PageChangedAction(this.page, this.pageIndex);

  @override
  AppState handle(AppState state) {
    final newState = state.clone()
      ..appTitle = page.title
      ..currentPageIndex = pageIndex
      ..appActions = page.actionsFactory;

    return newState;
  }
}

// ignore: one_member_abstracts
abstract class IsAction {
  AppState handle(AppState state);
}

AppState reducer<T extends IsAction>(AppState state, T action) {
  final newState = action.handle(state);
  return newState;
}

Reducer<AppState> reducers() => combineReducers([
      new TypedReducer<AppState, ToggleFavoriteAction>(
          (state, action) => action.handle(state)),
      new TypedReducer<AppState, UpdateCityFilterAction>(
          (state, action) => action.handle(state)),
      new TypedReducer<AppState, UpdateDistanceFilterAction>(
          (state, action) => action.handle(state)),
      new TypedReducer<AppState, UpdatePriceFilterAction>(
          (state, action) => action.handle(state)),
      new TypedReducer<AppState, UpdateSortingCriteriaAction>(
          (state, action) => action.handle(state)),
      new TypedReducer<AppState, FetchEventsAction>(
          (state, action) => action.handle(state)),
      new TypedReducer<AppState, ResetFiltersAction>(
          (state, action) => action.handle(state)),
      new TypedReducer<AppState, PageChangedAction>(
          (state, action) => action.handle(state)),
    ]);
