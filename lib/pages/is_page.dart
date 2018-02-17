import 'package:flutter/widgets.dart';

abstract class IsPage {
  String get title;

  List<Widget> actions(BuildContext context) => [];
}
