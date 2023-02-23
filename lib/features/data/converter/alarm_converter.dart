import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

class AlarmConverter extends TypeConverter<TimeOfDay?, String?> {
  @override
  TimeOfDay? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    } else {
      return TimeOfDay(
        hour: int.parse(databaseValue.split(':')[0]),
        minute: int.parse(databaseValue.split(':')[1]),
      );
    }
  }

  @override
  String? encode(TimeOfDay? value) {
    return (value != null) ? '${value.hour}:${value.minute}' : null;
  }
}
