import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:notepad_flutter/features/presentation/pages/dialogs/category_dialog.dart';

import '../presentation/pages/dialogs/delete_note_dialog.dart';

/// This function is used for showing the category icon for each note in
/// the home page.
IconData getCategoryIconForNoteCard(NoteCategory category) {
  switch (category) {
    case NoteCategory.personal:
      return Icons.person;
    case NoteCategory.business:
      return Icons.business;
    case NoteCategory.shopping:
      return Icons.shopping_cart;
    case NoteCategory.all:
      return Icons.all_inclusive;
  }
}

/// This function is used when the user wants to delete the note. It shows
/// a dialog.
Future<bool?> showDeleteNoteDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return const DeleteNoteDialog();
    },
  );
}

/// This function is used when the user wants to change categories. It shows
/// a dialog.
Future<NoteCategory?> showCategoryDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return const CategoryDialog();
    },
  );
}
