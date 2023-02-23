import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad_flutter/features/controller/home_screen_controller.dart';
import 'package:notepad_flutter/features/presentation/pages/dialogs/category_dialog.dart';
import 'package:notepad_flutter/features/presentation/widgets/note_card.dart';
import '../../data/entity/note.dart';
import 'dialogs/delete_note_dialog.dart';
import 'note_screen.dart';

///This is the home page where the user can see all their notes.
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final c = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Obx(() => Icon(c.categoryIcon.value)),

        /// Search Notes Text Field
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search your notes...',
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              c.isSearching.value = true;
              c.searchText.value = value;
            } else {
              c.isSearching.value = false;
              c.searchText.value = '';
            }
          },
        ),
        actions: [
          /// Category Selection Action
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
              stream: c.getStream(),
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
                        note: notes[index],
                        onDismissed: () async {
                          final result = await showDialog(
                            context: context,
                            builder: (builder) => const DeleteNoteDialog(),
                          );

                          if (result != null && result == true) {
                            c.m.noteDao.deleteNote(notes[index]);
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

      /// Create Note Button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(() => const NoteScreen()),
      ),
    );
  }
}
