import 'package:flutter/material.dart';
import '../../../../core/note_category.dart';

class CategoryDialog extends StatelessWidget {
  const CategoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, NoteCategory.all);
          },
          child: const Text('Show all notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, NoteCategory.personal);
          },
          child: const Text('Show personel notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, NoteCategory.business);
          },
          child: const Text('Show business notes'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, NoteCategory.shopping);
          },
          child: const Text('Show shopping notes'),
        ),
      ],
    );
  }
}
