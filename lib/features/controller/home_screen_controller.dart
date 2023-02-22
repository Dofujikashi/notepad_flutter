import 'package:get/get.dart';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:notepad_flutter/features/data/dao/note_dao.dart';

class HomeScreenController extends GetxController {
  final NoteDao noteDao;

  HomeScreenController({required this.noteDao});

  var title = 'My Notes'.obs;
  var selectedCategory = NoteCategory.all.obs;
}
