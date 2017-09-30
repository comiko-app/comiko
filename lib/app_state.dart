import 'package:comiko/models.dart';
import 'package:comiko/services.dart';
import 'package:comiko/widgets/event_card.dart';

class AppState {
  List<EventCardViewModel> events;
  SortingCriteria sortingCriteria;
  EventService eventsService = ServiceProvider.get<EventService>(EventService);

  AppState.initial() {
    events = eventsService
        .getAll()
        .map((Event e) => new EventCardViewModel(event: e))
        .toList();

    sortingCriteria = SortingCriteria.date;
  }

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
  final EventCardViewModel viewModel;

  ToggleFavoriteAction(this.viewModel);

  @override
  AppState handle(AppState state) {
    viewModel.isFavorite = !viewModel.isFavorite;

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

abstract class IsAction {
  AppState handle(AppState state);
}

AppState reducer<T extends IsAction>(AppState state, T action) {
  state = state.clone();
  state = action.handle(state);
  return state;
}
