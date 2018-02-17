import 'package:comiko/widgets/navigation_icon_view.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BottomBar extends StatefulWidget {
  final List<NavigationIconView> navigationViews;

  BottomBar({
    @required this.navigationViews,
  });

  @override
  BottomBarState createState() =>
      new BottomBarState(navigationViews: navigationViews);
}

class BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  final List<NavigationIconView> navigationViews;

  BottomBarState({
    @required this.navigationViews,
  });

  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
      items: navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (int index) {
        setState(() {
          navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          navigationViews[_currentIndex].controller.forward();
        });
      },
    );
  }

  @override
  void dispose() {
    for (NavigationIconView view in navigationViews) {
      view.controller.dispose();
    }

    super.dispose();
  }
}
