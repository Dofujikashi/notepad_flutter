import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:notepad_flutter/core/note_color.dart';
import 'package:notepad_flutter/features/controller/note_screen_controller.dart';
import 'package:notepad_flutter/features/presentation/widgets/alarm_widget.dart';
import 'package:notepad_flutter/features/presentation/widgets/category_picker_row.dart';
import '../../data/entity/note.dart';
import '../widgets/color_picker_row.dart';
import 'package:get/get.dart';

/// This is the detailed note screen, where the user can create/update
/// their notes.
class NoteScreen extends StatefulWidget {
  final Note? note;

  const NoteScreen({
    Key? key,
    this.note,
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
    if (widget.note != null) {
      c.selectedCategory.value = widget.note?.category ?? NoteCategory.personal;
      c.selectedColor.value = widget.note?.color ?? NoteColor.amber;
      c.setStringOfAlarm(widget.note?.alarm);
      c.setPageColor(widget.note?.color);
    }
    return Obx(
      () => Scaffold(
        backgroundColor: c.pageColor.value,
        appBar: AppBar(
          backgroundColor: c.selectedColor.value.color,
          title: Text(widget.note?.title ?? 'Create New Note'),
          actions: [
            /// Set Alarm Action
            IconButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  );
                  if (time != null) {
                    c.alarm.value = '${time.hour}:${time.minute}';
                  }
                },
                icon: const Icon(Icons.alarm)),

            /// Remove Image Action
            IconButton(
              onPressed: () {
                setState(() {
                  image = null;
                });
              },
              icon: const Icon(Icons.no_photography_rounded),
            ),

            /// Create/Update Action
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
                    (c.alarm.value != '')
                        ? TimeOfDay(
                            hour: c.getHourFromAlarm(),
                            minute: c.getMinuteFromAlarm(),
                          )
                        : null,
                  );
                  (widget.note == null)
                      ? c.m.noteDao.insertNote(n)
                      : c.m.noteDao.updateNote(n);
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
                /// Alarm Widget
                Obx(
                  () => (c.alarm.value == '') ? Container() : AlarmCard(),
                ),
                CategoryPickerRow(),
                ColorPickerRow(),
                const SizedBox(height: 8),

                /// Image Display
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () async {
                      final xFile = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (xFile != null) {
                        Uint8List bytes = await xFile.readAsBytes();
                        setState(() {
                          image = MemoryImage(bytes);
                        });
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: (image == null)
                          ? Icon(
                              Icons.add_photo_alternate,
                              size: 40,
                              color: c.selectedColor.value.color,
                            )
                          : Image.memory(image!.bytes),
                    ),
                  ),
                ),

                /// Title Text Field
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

                /// Note Text Field
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
      ),
    );
  }
}
