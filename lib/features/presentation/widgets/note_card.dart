import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_color.dart';
import 'package:notepad_flutter/features/controller/home_screen_controller.dart';
import 'package:notepad_flutter/features/data/entity/note.dart';
import 'package:notepad_flutter/features/presentation/pages/note_screen.dart';
import 'package:get/get.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function onDismissed;

  NoteCard({
    Key? key,
    required this.note,
    required this.onDismissed,
  }) : super(key: key);

  final HomeScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red.shade900,
        child: const Icon(Icons.delete),
      ),
      key: ValueKey<int?>(note.id),
      onDismissed: (direction) {
        onDismissed.call();
      },
      child: ListTile(
          shape: const Border(bottom: BorderSide()),
          leading: Icon(
            c.getCategoryIcon(note.category),
            color: Colors.black,
          ),
          tileColor: note.color.color,
          title: Text(
            note.title,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () => Get.to(NoteScreen(note: note))),
    );
  }
}
