import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:notepad_flutter/features/controller/home_screen_controller.dart';
import 'package:notepad_flutter/features/presentation/pages/dialogs/category_dialog.dart';
import 'package:notepad_flutter/features/presentation/widgets/note_card.dart';
import '../../data/dao/note_dao.dart';
import '../../data/entity/note.dart';
import 'dialogs/delete_note_dialog.dart';
import 'note_screen.dart';

///This is the home page where the user can see all their notes.
class HomeScreen extends StatefulWidget {
  final NoteDao noteDao;

  const HomeScreen({
    Key? key,
    required this.noteDao,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final c = Get.put(HomeScreenController(noteDao: widget.noteDao));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(c.title.value)),
        actions: [
          /// By default, the app shows all the notes, but the user can
          /// change the category using this button. Note that the AppBar
          /// title also changes when changing category.
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (_) => CategoryDialog());
            },
            icon: const Icon(Icons.category),
          ),
        ],
      ),

      /// This is the place where all the notes are listed.
      ///
      /// The notes will be displayed depending on the category chosen.
      /// All notes will be displayed by default.
      ///
      /// It uses Stream result of the database to build the display.
      /// The Stream will change when there is an Insert, Update or Delete
      /// used.
      ///
      /// The user can see/update their note by tapping on to the
      /// note card. They can delete a note by swapping the note card and
      /// confirming the dialog.
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(
            () => StreamBuilder<List<Note>>(
              stream: (c.selectedCategory.value == NoteCategory.all)
                  ? widget.noteDao.getNotes()
                  : widget.noteDao
                      .getNotesByCategory(c.selectedCategory.value.index),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else if (snapshot.data!.isEmpty) {
                  return const ListTile(
                    title: Text('You have no notes.'),
                  );
                } else {
                  final notes = snapshot.requireData;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: notes.length,
                    itemBuilder: (_, index) {
                      return NoteCard(
                        noteDao: widget.noteDao,
                        note: notes[index],
                        onDismissed: () async {
                          final result = await showDialog(
                            context: context,
                            builder: (builder) => const DeleteNoteDialog(),
                          );

                          if (result != null && result == true) {
                            widget.noteDao.deleteNote(notes[index]);
                          }

                          setState(() {
                            notes.removeAt(index);
                          });
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),

      /// The user can create new notes by using this button.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => NoteScreen(noteDao: widget.noteDao));
        },
      ),
    );
  }
}
