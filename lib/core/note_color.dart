import 'package:flutter/material.dart';

enum NoteColor {
  amber(Colors.amber),
  grey(Colors.grey),
  red(Colors.red),
  green(Colors.green),
  blue(Colors.blue);

  final MaterialColor color;
  const NoteColor(this.color);
}
