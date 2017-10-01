import 'package:comiko/models.dart';
import 'package:comiko/services.dart';
import 'package:comiko/widgets/event_card.dart';

class AppState {
  List<Event> events;
  Map<Event, bool> eventsFavoriteState = {};
  SortingCriteria sortingCriteria;
  EventService eventsService = ServiceProvider.get<EventService>(EventService);

  AppState.initial() {
    events = eventsService.getAll().toList();

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

  AppState._(
    this.events,
      this.sortingCriteria,
  );

  AppState clone() {
    var newState = new AppState._(
      new List.from(events),
      sortingCriteria,
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
    state.events = eventService.getAll().toList();

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
