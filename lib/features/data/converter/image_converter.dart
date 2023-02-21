import 'dart:typed_data';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

class ImageConverter extends TypeConverter<MemoryImage?, Uint8List?> {
  @override
  MemoryImage? decode(Uint8List? databaseValue) {
    return (databaseValue == null) ? null : MemoryImage(databaseValue);
  }

  @override
  Uint8List? encode(MemoryImage? value) {
    return value?.bytes;
  }
}
