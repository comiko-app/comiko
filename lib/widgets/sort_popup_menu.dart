import 'package:comiko/app_state.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SortPopupMenu extends StatelessWidget {
  final Store<AppState> store;

  const SortPopupMenu({
    @required this.store,
  });

  @override
  Widget build(BuildContext context) => new PopupMenuButton<SortingCriteria>(
        icon: const Icon(Icons.sort),
        onSelected: (result) {
          store.dispatch(new UpdateSortingCriteriaAction(result));
        },
        itemBuilder: (context) => <PopupMenuEntry<SortingCriteria>>[
              new CheckedPopupMenuItem<SortingCriteria>(
                checked: store.state.sortingCriteria == SortingCriteria.date,
                value: SortingCriteria.date,
                child: const Text('Date'),
              ),
              new CheckedPopupMenuItem<SortingCriteria>(
                checked:
                    store.state.sortingCriteria == SortingCriteria.distance,
                value: SortingCriteria.distance,
                child: const Text('Distance'),
              ),
              new CheckedPopupMenuItem<SortingCriteria>(
                checked: store.state.sortingCriteria == SortingCriteria.price,
                value: SortingCriteria.price,
                child: const Text('Prix'),
              ),
            ],
      );
}
