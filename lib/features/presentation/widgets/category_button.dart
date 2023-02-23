import 'package:flutter/material.dart';
import 'package:notepad_flutter/features/controller/note_screen_controller.dart';
import 'package:get/get.dart';

class CategoryButton extends StatelessWidget {
  final Function function;
  final String title;
  final IconData icon;

  CategoryButton({
    Key? key,
    required this.function,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final NoteScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FilledButton(
        onPressed: () => function.call(),
        style: OutlinedButton.styleFrom(
          backgroundColor: c.selectedColor.value.color,
          side: BorderSide(
            width: 2,
            color: (c.selectedCategory.value.name == title.toLowerCase())
                ? Colors.black
                : c.selectedColor.value.color,
          ),
        ),
        child: Row(
          children: [
            Icon(icon),
            Text(title),
          ],
        ),
      ),
    );
  }
}
