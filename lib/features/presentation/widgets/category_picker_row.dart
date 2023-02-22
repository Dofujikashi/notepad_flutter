import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:notepad_flutter/features/controller/note_screen_controller.dart';
import 'package:notepad_flutter/features/presentation/widgets/category_button.dart';
import 'package:get/get.dart';

class CategoryPickerRow extends StatelessWidget {
  CategoryPickerRow({
    Key? key,
  }) : super(key: key);

  final NoteScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CategoryButton(
          function: () => c.selectedCategory.value = NoteCategory.personal,
          title: 'Personal',
          icon: Icons.person,
        ),
        CategoryButton(
          function: () => c.selectedCategory.value = NoteCategory.business,
          title: 'Business',
          icon: Icons.business,
        ),
        CategoryButton(
          function: () => c.selectedCategory.value = NoteCategory.shopping,
          title: 'Shopping',
          icon: Icons.shopping_cart,
        ),
      ],
    );
  }
}
