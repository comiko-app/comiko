import 'package:comiko/models.dart';
import 'package:comiko/services.dart';
import 'package:comiko/widgets/event_card.dart';

class AppState {
  List<Event> events;
  Map<Event, bool> eventsFavoriteState = {};
  SortingCriteria sortingCriteria;
  EventService eventsService = ServiceProvider.get<EventService>(EventService);

  AppState.initial() {
    events = eventsService.getAll();

    for (var event in events) {
      eventsFavoriteState[event] = false;
    }

    sortingCriteria = SortingCriteria.date;
  }

  EventCardViewModel createViewModel(Event event) =>
      new EventCardViewModel(
        event: event,
        isFavorite: eventsFavoriteState[event],
      );

  List<EventCardViewModel> getFavoriteEvents() =>
      events
          .where((Event e) => eventsFavoriteState[e])
          .map((Event e) => new EventCardViewModel(event: e, isFavorite: true))
          .toList();

  AppState._(
    this.events,
      this.sortingCriteria,
      this.eventsFavoriteState,
  );

  AppState clone() {
    var newState = new AppState._(
      new List.from(events),
      sortingCriteria,
      new Map.from(eventsFavoriteState),
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

  @override
  AppState handle(AppState state) {
    state.sortingCriteria = criteria;

    return state;
  }
}

class FetchEventsAction extends IsAction {
  EventService eventService = ServiceProvider.get(EventService);

  @override
  AppState handle(AppState state) {
    state = state.clone();
    state.events = eventService.getAll();

    for (var event in state.events) {
      state.eventsFavoriteState[event] = false;
    }

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
