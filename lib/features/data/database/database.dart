import 'dart:async';
import 'package:floor/floor.dart';
import '../converter/image_converter.dart';
import 'package:notepad_flutter/core/note_color.dart';
import '../dao/note_dao.dart';
import '../entity/note.dart';
import 'dart:typed_data';
import 'package:notepad_flutter/core/note_category.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@TypeConverters([ImageConverter])
@Database(version: 1, entities: [Note])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
}
