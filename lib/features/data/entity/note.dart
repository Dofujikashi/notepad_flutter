import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:notepad_flutter/core/note_color.dart';
import '../../../core/note_category.dart';

@Entity()
class Note {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String? body;
  final NoteCategory category;
  final NoteColor color;
  final MemoryImage? image;
  final TimeOfDay? alarm;

  Note(this.id, this.title, this.category, this.body, this.color, this.image,
      this.alarm);

  @override
  String toString() {
    return '''
    Note 
      id: $id, 
      title: $title, 
      body: $body, 
      category: $category,
      color: $color,
      image: ${image?.bytes},
      alarm: ${alarm?.hour}:${alarm?.minute}
    ''';
  }
}
