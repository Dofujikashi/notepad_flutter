import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad_flutter/features/controller/note_screen_controller.dart';

class AlarmCard extends StatelessWidget {
  AlarmCard({Key? key}) : super(key: key);
  final NoteScreenController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => c.alarm.value = '',
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(c.getAlarmText()),
            const SizedBox(width: 8),
            const Icon(
              Icons.cancel,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
