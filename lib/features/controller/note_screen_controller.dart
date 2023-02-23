import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad_flutter/features/controller/main_controller.dart';
import '../../core/note_category.dart';
import '../../core/note_color.dart';

class NoteScreenController extends GetxController {
  final MainController m = Get.find();

  var selectedCategory = NoteCategory.personal.obs;
  var selectedColor = NoteColor.amber.obs;
  var pageColor = Colors.amber.shade200.obs;
  var title = '';
  var body = '';
  var alarm = ''.obs;

  /// If the user came to update, sets the background color of the NoteScreen.
  void setPageColor(NoteColor? color) {
    pageColor.value = color?.color.shade200 ?? Colors.amber.shade200;
  }

  /// If the user came to update, sets the AlarmWidgets text with the selected
  /// time.
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

  /// For adding zeros to the AlarmWidget's text if hour/minute is less than 10.
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
