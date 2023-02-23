import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:notepad_flutter/features/controller/main_controller.dart';
import 'package:notepad_flutter/features/data/entity/note.dart';

class HomeScreenController extends GetxController {
  final MainController m = Get.find();

  var categoryIcon = Icons.all_inclusive.obs;
  var selectedCategory = NoteCategory.all.obs;
  var isSearching = false.obs;
  var searchText = ''.obs;

  /// Returns Icon based on Category.
  IconData getCategoryIcon(NoteCategory category) {
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

  /// Data stream for home page.
  Stream<List<Note>> getStream() {
    return (isSearching.value == false)
        ? (selectedCategory.value == NoteCategory.all)
            ? m.noteDao.getNotes()
            : m.noteDao.getNotesByCategory(selectedCategory.value.index)
        : m.noteDao.getNotesBySearch('%${searchText.value}%');
  }
}
