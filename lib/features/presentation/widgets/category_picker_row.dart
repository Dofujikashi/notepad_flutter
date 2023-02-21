import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:notepad_flutter/features/presentation/widgets/category_button.dart';

class CategoryPickerRow extends StatelessWidget {
  final List<Function> functions;
  final NoteCategory selectedCategory;

  const CategoryPickerRow({
    Key? key,
    required this.selectedCategory,
    required this.functions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CategoryButton(
          function: functions[0],
          title: 'Personal',
          icon: Icons.person,
          selectedCategory: selectedCategory,
        ),
        CategoryButton(
          function: functions[1],
          title: 'Business',
          icon: Icons.business,
          selectedCategory: selectedCategory,
        ),
        CategoryButton(
          function: functions[2],
          title: 'Shopping',
          icon: Icons.shopping_cart,
          selectedCategory: selectedCategory,
        ),
      ],
    );
  }
}
