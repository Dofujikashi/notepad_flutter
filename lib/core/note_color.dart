import 'package:flutter/material.dart';

enum NoteColor {
  amber(Colors.amber),
  white(Colors.white),
  red(Color(0xFFEF5350)),
  green(Color(0xFF66BB6A)),
  blue(Color(0xFF42A5F5)),
  black(Colors.black);

  final Color color;
  const NoteColor(this.color);
}
