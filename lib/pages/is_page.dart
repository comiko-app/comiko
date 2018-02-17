import 'package:flutter/widgets.dart';

typedef AppActionsFactory = List<Widget> Function(BuildContext);

abstract class IsPage extends Widget {
  String get title;

  AppActionsFactory get actionsFactory => (BuildContext c) => [];
}
