import 'package:flutter/material.dart';
import '../../../core/note_color.dart';

class ColorButton extends StatelessWidget {
  final Function function;
  final Color color;
  final NoteColor selectedColor;

  const ColorButton({
    Key? key,
    required this.function,
    required this.color,
    required this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => function.call(),
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(2),
          backgroundColor:
              (selectedColor.color == color) ? Colors.black : color),
      child: CircleAvatar(
        backgroundColor: color,
      ),
    );
  }
}
