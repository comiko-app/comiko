import 'package:flutter/material.dart';

class GridTileText extends StatelessWidget {
  const GridTileText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.scaleDown,
        alignment: FractionalOffset.centerLeft,
        child: Text(text),
      );
}
