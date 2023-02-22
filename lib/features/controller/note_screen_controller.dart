import 'package:get/get.dart';

import '../../core/note_category.dart';
import '../../core/note_color.dart';

class NoteScreenController extends GetxController {
  var selectedCategory = NoteCategory.personal.obs;
  var selectedColor = NoteColor.amber.obs;
  var title = '';
  var body = '';
}
