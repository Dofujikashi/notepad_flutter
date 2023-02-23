import 'package:flutter/material.dart';
import 'package:notepad_flutter/features/controller/home_screen_controller.dart';
import '../../../../core/note_category.dart';
import 'package:get/get.dart';
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
            c.title.value = 'My Notes';
            Get.back();
          },
          child: const Text('Show all notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            c.selectedCategory.value = NoteCategory.personal;
            c.title.value = 'Personal Notes';
            Get.back();
          },
          child: const Text('Show personel notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            c.selectedCategory.value = NoteCategory.business;
            c.title.value = 'Business Notes';
            Get.back();
          },
          child: const Text('Show business notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            c.selectedCategory.value = NoteCategory.shopping;
            c.title.value = 'Shopping Notes';
            Get.back();
          },
          child: const Text('Show shopping notes'),
        ),
      ],
    );
  }
}
