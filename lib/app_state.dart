import 'package:comiko/models.dart';
import 'package:comiko/services.dart';
import 'package:comiko/widgets/event_card.dart';

class AppState {
  List<EventCardViewModel> events;
  EventService eventsService = ServiceProvider.get(EventService);

  AppState.initial() {
    events = eventsService
        .getAll()
        .map((Event e) => new EventCardViewModel(event: e))
        .toList();
  }

  AppState._(
    this.events,
  );

  AppState clone() {
    var newState = new AppState._(
      new List.from(events),
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

abstract class IsAction {
  AppState handle(AppState state);
}

AppState reducer<T extends IsAction>(AppState state, T action) {
  state = state.clone();
  state = action.handle(state);
  return state;
}
