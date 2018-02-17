import 'package:flutter/widgets.dart';

typedef List<Widget> AppActionsFactory(BuildContext context);

abstract class IsPage extends Widget {
  String get title;

  AppActionsFactory get actionsFactory;
}
