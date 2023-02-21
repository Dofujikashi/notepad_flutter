import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:notepad_flutter/core/note_color.dart';
import 'package:notepad_flutter/features/data/dao/note_dao.dart';
import 'package:notepad_flutter/features/presentation/widgets/category_picker_row.dart';
import '../../data/entity/note.dart';
import '../widgets/color_picker_row.dart';

/// This is the detailed note screen, where the user can create/update
/// their notes.
class NoteScreen extends StatefulWidget {
  final NoteDao noteDao;
  final Note? note;

  const NoteScreen({
    Key? key,
    this.note,
    required this.noteDao,
  }) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

/// By default, the note category is Personal and note color is Amber.
/// If the user came to this page for updating their note, the default values
/// will be overwritten.
class _NoteScreenState extends State<NoteScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late NoteCategory selectedCategory =
      widget.note?.category ?? NoteCategory.personal;
  late NoteColor selectedColor = widget.note?.color ?? NoteColor.amber;
  late String title;
  late String note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note?.title ?? 'Create New Note'),
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
                  widget.note?.id,
                  title,
                  selectedCategory,
                  note,
                  selectedColor,
                  null, // Image uploading is not implemented yet.
                );
                (widget.note == null)
                    ? widget.noteDao.insertNote(n)
                    : widget.noteDao.updateNote(n);
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),

      /// This is the form part of the page.
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              /// CategoryPickerRow is a row with 3 buttons for changing
              /// the category.
              ///
              /// selectedCategory parameter is given so that the
              /// button displaying the current category looks selected
              /// (black border).
              ///
              /// functions parameter is given for the buttons to use
              /// the setState function outside of this class. The
              /// functions are given by order:
              /// 0 -> changes category to personel
              /// 1 -> changes category to business
              /// 2 -> changes category to shopping
              CategoryPickerRow(selectedCategory: selectedCategory, functions: [
                () => setState(() => selectedCategory = NoteCategory.personal),
                () => setState(() => selectedCategory = NoteCategory.business),
                () => setState(() => selectedCategory = NoteCategory.shopping),
              ]),

              /// ColorPickerRow is a row with 5 buttons for changing
              /// the color.
              ///
              /// selectedColor parameter is given so that the
              /// button displaying the current color looks selected
              /// (black border).
              ///
              /// functions parameter is given for the buttons to use
              /// the setState function outside of this class. The
              /// functions are given by order:
              /// 0 -> changes color to Amber
              /// 1 -> changes color to White
              /// 2 -> changes color to Red
              /// 3 -> changes color to Green
              /// 4 -> changes color to Blue
              ColorPickerRow(selectedColor: selectedColor, functions: [
                () => setState(() => selectedColor = NoteColor.amber),
                () => setState(() => selectedColor = NoteColor.white),
                () => setState(() => selectedColor = NoteColor.red),
                () => setState(() => selectedColor = NoteColor.green),
                () => setState(() => selectedColor = NoteColor.blue),
              ]),
              TextFormField(
                initialValue: widget.note?.title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty.';
                  } else {
                    title = value;
                    return null;
                  }
                },
              ),
              Expanded(
                child: TextFormField(
                  initialValue: widget.note?.body,
                  decoration: const InputDecoration(
                    hintText: 'Write your note',
                  ),
                  maxLines: 100,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Note cannot be empty.';
                    } else {
                      note = value;
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
