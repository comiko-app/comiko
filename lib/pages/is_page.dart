import 'package:flutter/widgets.dart';

abstract class IsPage extends Widget {
  String get title;

  List<Widget> actions(BuildContext context) => [];
}
