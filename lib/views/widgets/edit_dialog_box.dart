import 'package:flutter/material.dart';

Future<void> showEditDialogBox(
  BuildContext context, {
  required String title,
  required String value,
  required Function(String) onSave,
}) async {
  final TextEditingController controller = TextEditingController(text: value);
  final AlertDialog dialog = AlertDialog(
    title: Text('Modify $title?'),
    content: TextField(
      controller: controller,
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          onSave.call(controller.value.text);
          Navigator.pop(context);
        },
        child: const Text('Save'),
      )
    ],
  );

  await showDialog<void>(
      context: context, builder: (BuildContext context) => dialog);
  return;
}
