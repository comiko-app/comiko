import 'package:flutter/material.dart';

class SortPopupMenu extends StatelessWidget {
  const SortPopupMenu();

  @override
  Widget build(BuildContext context) => PopupMenuButton<bool>(
      icon: Icon(Icons.sort),
      onSelected: (result) {},
      itemBuilder: (context) => <PopupMenuEntry<bool>>[
            CheckedPopupMenuItem<bool>(
              checked: true,
              value: true,
              child: Text('Date'),
            ),
            CheckedPopupMenuItem<bool>(
              checked: true,
              value: true,
              child: Text('Distance'),
            ),
          ],
    );
}
