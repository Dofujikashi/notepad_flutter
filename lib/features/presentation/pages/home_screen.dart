import 'package:flutter/material.dart';
import 'package:notepad_flutter/features/data/entity/note.dart';
import 'package:notepad_flutter/features/presentation/widgets/note_card.dart';
import 'package:notepad_flutter/features/utility/presentation_utility.dart';
import '../../../core/note_category.dart';
import '../../data/dao/note_dao.dart';
import 'note_screen.dart';

///This is the home page where the user can see all their notes.
class HomeScreen extends StatefulWidget {
  final NoteDao noteDao;

  const HomeScreen({Key? key, required this.noteDao}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NoteCategory selectedCategory = NoteCategory.all;
  String title = 'My Notes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            /// This is the state logic for changing category.
            ///
            /// By default, the app shows all the notes, but the user can
            /// change the category using this button. Note that the AppBar
            /// title also changes when changing category.
            ///
            /// It is using switch because NoteCategory is an enum.
            onPressed: () async {
              switch (await showCategoryDialog(context)) {
                case NoteCategory.all:
                  setState(() {
                    selectedCategory = NoteCategory.all;
                    title = 'My Notes';
                  });
                  break;
                case NoteCategory.personal:
                  setState(() {
                    selectedCategory = NoteCategory.personal;
                    title = 'Personel Notes';
                  });
                  break;
                case NoteCategory.business:
                  setState(() {
                    selectedCategory = NoteCategory.business;
                    title = 'Business Notes';
                  });
                  break;
                case NoteCategory.shopping:
                  setState(() {
                    selectedCategory = NoteCategory.shopping;
                    title = 'Shopping Notes';
                  });
                  break;
                case null:
                  break;
              }
            },
            icon: const Icon(Icons.category),
          )
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
          StreamBuilder<List<Note>>(
            stream: (selectedCategory == NoteCategory.all)
                ? widget.noteDao.getNotes()
                : widget.noteDao.getNotesByCategory(selectedCategory.index),
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
                        final result = await showDeleteNoteDialog(context);
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
        ],
      ),

      /// The user can create new notes by using this button.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return NoteScreen(noteDao: widget.noteDao);
              },
            ),
          );
        },
      ),
    );
  }
}
