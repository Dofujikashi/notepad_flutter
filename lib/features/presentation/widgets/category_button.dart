import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_category.dart';

import '../../../core/note_color.dart';

class CategoryButton extends StatelessWidget {
  final Function function;
  final NoteCategory selectedCategory;
  final String title;
  final IconData icon;

  const CategoryButton({
    Key? key,
    required this.function,
    required this.selectedCategory,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 2,
          color: (selectedCategory.name == title.toLowerCase())
              ? Colors.black
              : NoteColor.amber.color,
        ),
      ),
      onPressed: () => function.call(),
      child: Row(
        children: [
          Icon(icon),
          Text(title),
        ],
      ),
    );
  }
}
