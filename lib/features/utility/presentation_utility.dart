import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_category.dart';

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
