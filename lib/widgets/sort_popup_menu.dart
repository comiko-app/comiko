import 'package:comiko/app_state.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:comiko_shared/models.dart';

class SortPopupMenu extends StatelessWidget {
  final Store<AppState> store;

  SortPopupMenu({
    @required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton<SortingCriteria>(
      icon: const Icon(Icons.sort),
      onSelected: (SortingCriteria result) {
        store.dispatch(new UpdateSortingCriteriaAction(result));
      },
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry<SortingCriteria>>[
        new CheckedPopupMenuItem<SortingCriteria>(
          checked: store.state.sortingCriteria == SortingCriteria.date,
          value: SortingCriteria.date,
          child: const Text('Date'),
        ),
        new CheckedPopupMenuItem<SortingCriteria>(
          checked: store.state.sortingCriteria == SortingCriteria.distance,
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
}
