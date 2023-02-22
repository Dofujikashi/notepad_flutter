import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
class NoteScreen extends StatefulWidget {
  final NoteDao noteDao;
  final Note? note;

  NoteScreen({
    Key? key,
    this.note,
    required this.noteDao,
  }) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final c = Get.put(NoteScreenController());
  final imagePicker = ImagePicker();
  late MemoryImage? image = widget.note?.image;

  @override
  Widget build(BuildContext context) {
    /// If the user came to this page for updating their note, the default
    /// values will be overwritten.
    c.selectedCategory.value = widget.note?.category ?? NoteCategory.personal;
    c.selectedColor.value = widget.note?.color ?? NoteColor.amber;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note?.title ?? 'Create New Note'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                image = null;
              });
            },
            icon: const Icon(Icons.no_photography_rounded),
          ),

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
                  c.title,
                  c.selectedCategory.value,
                  c.body,
                  c.selectedColor.value,
                  image,
                );
                (widget.note == null)
                    ? widget.noteDao.insertNote(n)
                    : widget.noteDao.updateNote(n);
                Get.back();
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
              const SizedBox(height: 8),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.amber,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final xFile = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (xFile != null) {
                        setState(() {
                          xFile.readAsBytes().then((value) {
                            image = MemoryImage(value);
                          });
                        });
                      }
                    },
                    icon: (image == null)
                        ? const Icon(Icons.photo, size: 40)
                        : Image.memory(image!.bytes),
                  ),
                ),
              ),
              TextFormField(
                initialValue: widget.note?.title,
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
                flex: 2,
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
