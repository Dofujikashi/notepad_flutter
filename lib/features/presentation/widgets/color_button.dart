import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad_flutter/features/controller/note_screen_controller.dart';

class ColorButton extends StatelessWidget {
  final Function function;
  final Color color;

  ColorButton({
    Key? key,
    required this.function,
    required this.color,
  }) : super(key: key);

  final NoteScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: () => function.call(),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(2),
            backgroundColor:
                (c.selectedColor.value.color == color) ? Colors.black : color),
        child: CircleAvatar(
          backgroundColor: color,
        ),
      ),
    );
  }
}
