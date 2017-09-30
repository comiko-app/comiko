import 'package:flutter/material.dart';

enum filterType { Distance, Price, Date }

class FilterPopupMenu extends StatelessWidget {
  FilterPopupMenu();

  var _selection;

  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton<filterType>(
      onSelected: (filterType result) {},
      itemBuilder: (BuildContext context) => <PopupMenuEntry<filterType>>[
        const PopupMenuItem<filterType>(
          value: filterType.Distance,
          child: const Text('Distance'),
        ),
        const PopupMenuItem<filterType>(
          value: filterType.Price,
          child: const Text('Price'),
        ),
        const PopupMenuItem<filterType>(
          value: filterType.Date,
          child: const Text('Date'),
        ),
      ],
    );
  }
}
