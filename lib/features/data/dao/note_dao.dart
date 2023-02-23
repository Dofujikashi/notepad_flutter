import 'package:floor/floor.dart';
import '../entity/note.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM Note')
  Stream<List<Note>> getNotes();

  @Query('SELECT * FROM Note WHERE category = :categoryIndex')
  Stream<List<Note>> getNotesByCategory(int categoryIndex);

  @Query('SELECT * FROM Note WHERE title LIKE :title')
  Stream<List<Note>> getNotesBySearch(String title);

  @insert
  Future<void> insertNote(Note note);

  @update
  Future<void> updateNote(Note note);

  @delete
  Future<void> deleteNote(Note note);

  @Query('DELETE FROM Note')
  Future<void> deleteAllNotes();
}
