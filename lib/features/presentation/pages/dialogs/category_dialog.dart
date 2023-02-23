import 'package:flutter/material.dart';
import 'package:notepad_flutter/features/controller/home_screen_controller.dart';
import '../../../../core/note_category.dart';
import 'package:get/get.dart';

class CategoryDialog extends StatelessWidget {
  CategoryDialog({Key? key}) : super(key: key);

  final HomeScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: () {
            c.selectedCategory.value = NoteCategory.all;
            c.categoryIcon.value = c.getCategoryIcon(NoteCategory.all);
            Get.back();
          },
          child: const Text('Show all notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            c.selectedCategory.value = NoteCategory.personal;
            c.categoryIcon.value = c.getCategoryIcon(NoteCategory.personal);
            Get.back();
          },
          child: const Text('Show personel notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            c.selectedCategory.value = NoteCategory.business;
            c.categoryIcon.value = c.getCategoryIcon(NoteCategory.business);
            Get.back();
          },
          child: const Text('Show business notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            c.selectedCategory.value = NoteCategory.shopping;
            c.categoryIcon.value = c.getCategoryIcon(NoteCategory.shopping);
            Get.back();
          },
          child: const Text('Show shopping notes'),
        ),
      ],
    );
  }
}
