import 'package:flutter/material.dart';
import '../../../core/note_color.dart';
import 'color_button.dart';

class ColorPickerRow extends StatelessWidget {
  final List<Function> functions;
  final NoteColor selectedColor;

  const ColorPickerRow({
    Key? key,
    required this.functions,
    required this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColorButton(
          function: functions[0],
          color: NoteColor.amber.color,
          selectedColor: selectedColor,
        ),
        ColorButton(
          function: functions[1],
          color: NoteColor.white.color,
          selectedColor: selectedColor,
        ),
        ColorButton(
          function: functions[2],
          color: NoteColor.red.color,
          selectedColor: selectedColor,
        ),
        ColorButton(
          function: functions[3],
          color: NoteColor.green.color,
          selectedColor: selectedColor,
        ),
        ColorButton(
          function: functions[4],
          color: NoteColor.blue.color,
          selectedColor: selectedColor,
        ),
      ],
    );
  }
}
