import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextLabel extends StatelessWidget {
  final String text;

  const TextLabel(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.body1,
    );
  }
}
