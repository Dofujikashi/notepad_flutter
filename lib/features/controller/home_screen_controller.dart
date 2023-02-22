import 'package:get/get.dart';
import 'package:notepad_flutter/core/note_category.dart';

class HomeScreenController extends GetxController {
  var title = 'My Notes'.obs;
  var selectedCategory = NoteCategory.all.obs;
}
