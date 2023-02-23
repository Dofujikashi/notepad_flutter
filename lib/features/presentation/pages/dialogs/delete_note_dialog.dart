import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteNoteDialog extends StatelessWidget {
  const DeleteNoteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text(
        'You are about to delete a note. This action can not be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: const Text(
            'Go back',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
