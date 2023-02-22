import 'package:flutter/material.dart';
import 'package:notepad_flutter/features/controller/home_screen_controller.dart';
import '../../../../core/note_category.dart';
import 'package:get/get.dart';

class CategoryDialog extends StatelessWidget {
  CategoryDialog({Key? key}) : super(key: key);

  final HomeScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: () {
            controller.selectedCategory.value = NoteCategory.all;
            controller.title.value = 'My Notes';
            Navigator.pop(context);
          },
          child: const Text('Show all notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            controller.selectedCategory.value = NoteCategory.personal;
            controller.title.value = 'Personal Notes';
            Navigator.pop(context);
          },
          child: const Text('Show personel notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            controller.selectedCategory.value = NoteCategory.business;
            controller.title.value = 'Business Notes';
            Navigator.pop(context);
          },
          child: const Text('Show business notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            controller.selectedCategory.value = NoteCategory.shopping;
            controller.title.value = 'Shopping Notes';
            Navigator.pop(context);
          },
          child: const Text('Show shopping notes'),
        ),
      ],
    );
  }
}
