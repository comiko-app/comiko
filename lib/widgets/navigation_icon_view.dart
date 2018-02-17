import 'package:flutter/material.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget body,
    Widget title,
    Color color,
    TickerProvider vsync,
  })
      : _body = body,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: title,
          backgroundColor: color,
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _body;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(BuildContext context) {
    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02),
          end: Offset.zero,
        )
            .animate(_animation),
        child: _body,
      ),
    );
  }
}