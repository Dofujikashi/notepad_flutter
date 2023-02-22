import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:notepad_flutter/core/note_color.dart';
import 'package:notepad_flutter/features/controller/note_screen_controller.dart';
import 'package:notepad_flutter/features/data/dao/note_dao.dart';
import 'package:notepad_flutter/features/presentation/widgets/category_picker_row.dart';
import '../../data/entity/note.dart';
import '../widgets/color_picker_row.dart';
import 'package:get/get.dart';

/// This is the detailed note screen, where the user can create/update
/// their notes.
class NoteScreen extends StatelessWidget {
  final NoteDao noteDao;
  final Note? note;

  NoteScreen({
    Key? key,
    this.note,
    required this.noteDao,
  }) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final c = Get.put(NoteScreenController());

  @override
  Widget build(BuildContext context) {
    /// If the user came to this page for updating their note, the default
    /// values will be overwritten.
    c.selectedCategory.value = note?.category ?? NoteCategory.personal;
    c.selectedColor.value = note?.color ?? NoteColor.amber;

    return Scaffold(
      appBar: AppBar(
        title: Text(note?.title ?? 'Create New Note'),
        actions: [
          /// This button controls the fields required for the database and
          /// create/update a note, but if the requirement are not met,
          /// error messages will show up.
          ///
          /// It creates a new note if the user came to this page by using
          /// the floating action button. Otherwise it will update the note.
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Note n = Note(
                  note?.id,
                  c.title,
                  c.selectedCategory.value,
                  c.body,
                  c.selectedColor.value,
                  null, // Image uploading is not implemented yet.
                );
                (note == null) ? noteDao.insertNote(n) : noteDao.updateNote(n);
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CategoryPickerRow(),
              ColorPickerRow(),
              TextFormField(
                initialValue: note?.title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty.';
                  } else {
                    c.title = value;
                    return null;
                  }
                },
              ),
              Expanded(
                child: TextFormField(
                  initialValue: note?.body,
                  decoration: const InputDecoration(
                    hintText: 'Write your note',
                  ),
                  maxLines: 100,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Note cannot be empty.';
                    } else {
                      c.body = value;
                      return null;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
