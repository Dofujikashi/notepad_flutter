import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_color.dart';
import 'package:notepad_flutter/features/data/dao/note_dao.dart';
import 'package:notepad_flutter/features/data/entity/note.dart';
import 'package:notepad_flutter/features/presentation/pages/note_screen.dart';

import '../../../core/note_category.dart';

class NoteCard extends StatelessWidget {
  final NoteDao noteDao;
  final Note note;
  final Function onDismissed;

  const NoteCard({
    Key? key,
    required this.note,
    required this.noteDao,
    required this.onDismissed,
  }) : super(key: key);

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
          getCategoryIconForNoteCard(note.category),
          color: NoteColor.black.color,
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return NoteScreen(
                  noteDao: noteDao,
                  note: note,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

IconData getCategoryIconForNoteCard(NoteCategory category) {
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
