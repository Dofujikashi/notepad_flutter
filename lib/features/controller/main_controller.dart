import 'package:get/get.dart';
import 'package:notepad_flutter/features/data/dao/note_dao.dart';

class MainController extends GetxController {
  final NoteDao noteDao;

  MainController(this.noteDao);
}
