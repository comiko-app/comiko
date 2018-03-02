import 'package:comiko/app_state.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SortPopupMenu extends StatelessWidget {
  const SortPopupMenu();

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of(context).store;
    return PopupMenuButton<SortingCriteria>(
      icon: Icon(Icons.sort),
      onSelected: (result) {
        store.dispatch(UpdateSortingCriteriaAction(result));
      },
      itemBuilder: (context) => <PopupMenuEntry<SortingCriteria>>[
            CheckedPopupMenuItem<SortingCriteria>(
              checked: store.state.sortingCriteria == SortingCriteria.date,
              value: SortingCriteria.date,
              child: Text('Date'),
            ),
            CheckedPopupMenuItem<SortingCriteria>(
              checked: store.state.sortingCriteria == SortingCriteria.distance,
              value: SortingCriteria.distance,
              child: Text('Distance'),
            ),
            CheckedPopupMenuItem<SortingCriteria>(
              checked: store.state.sortingCriteria == SortingCriteria.price,
              value: SortingCriteria.price,
              child: Text('Prix'),
            ),
          ],
    );
  }
}
