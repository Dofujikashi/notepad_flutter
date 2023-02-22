import 'package:flutter/material.dart';
import 'package:notepad_flutter/features/controller/note_screen_controller.dart';
import '../../../core/note_color.dart';
import 'color_button.dart';
import 'package:get/get.dart';

class ColorPickerRow extends StatelessWidget {
  ColorPickerRow({
    Key? key,
  }) : super(key: key);

  final NoteScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColorButton(
          function: () => c.selectedColor.value = NoteColor.amber,
          color: NoteColor.amber.color,
        ),
        ColorButton(
          function: () => c.selectedColor.value = NoteColor.white,
          color: NoteColor.white.color,
        ),
        ColorButton(
          function: () => c.selectedColor.value = NoteColor.red,
          color: NoteColor.red.color,
        ),
        ColorButton(
          function: () => c.selectedColor.value = NoteColor.green,
          color: NoteColor.green.color,
        ),
        ColorButton(
          function: () => c.selectedColor.value = NoteColor.blue,
          color: NoteColor.blue.color,
        ),
      ],
    );
  }
}
