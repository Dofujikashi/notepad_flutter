import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/note_category.dart';
import '../../core/note_color.dart';

class NoteScreenController extends GetxController {
  var selectedCategory = NoteCategory.personal.obs;
  var selectedColor = NoteColor.amber.obs;
  var title = '';
  var body = '';
  var alarm = ''.obs;

  void setStringOfAlarm(TimeOfDay? noteAlarm) {
    if (noteAlarm != null) {
      alarm.value = '${noteAlarm.hour}:${noteAlarm.minute}';
    } else {
      alarm.value = '';
    }
  }

  int getHourFromAlarm() {
    return int.parse(alarm.value.split(':')[0]);
  }

  int getMinuteFromAlarm() {
    return int.parse(alarm.value.split(':')[1]);
  }

  String getAlarmText() {
    String alarmText = '';
    int hour = int.parse(alarm.value.split(':')[0]);
    int minute = int.parse(alarm.value.split(':')[1]);

    if (hour < 10) {
      alarmText += '0$hour';
    } else {
      alarmText += '$hour';
    }

    alarmText += ':';

    if (minute < 10) {
      alarmText += '0$minute';
    } else {
      alarmText += '$minute';
    }

    return alarmText;
  }
}
