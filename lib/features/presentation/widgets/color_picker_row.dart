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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ColorButton(
          function: () {
            c.selectedColor.value = NoteColor.amber;
            c.pageColor.value = NoteColor.amber.color.shade200;
          },
          color: NoteColor.amber.color,
        ),
        ColorButton(
          function: () {
            c.selectedColor.value = NoteColor.grey;
            c.pageColor.value = NoteColor.grey.color.shade200;
          },
          color: NoteColor.grey.color,
        ),
        ColorButton(
          function: () {
            c.selectedColor.value = NoteColor.red;
            c.pageColor.value = NoteColor.red.color.shade200;
          },
          color: NoteColor.red.color,
        ),
        ColorButton(
          function: () {
            c.selectedColor.value = NoteColor.green;
            c.pageColor.value = NoteColor.green.color.shade200;
          },
          color: NoteColor.green.color,
        ),
        ColorButton(
          function: () {
            c.selectedColor.value = NoteColor.blue;
            c.pageColor.value = NoteColor.blue.color.shade200;
          },
          color: NoteColor.blue.color,
        ),
      ],
    );
  }
}
