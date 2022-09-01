import 'package:flutter/material.dart';

typedef OnUpdateValue = Function(String);

Future<void> showDeleteDialogBox(
  BuildContext context, {
  required VoidCallback onDelete,
}) async {
  final AlertDialog dialog = AlertDialog(
    title: const Text('Delete this pokemon?'),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('No'),
      ),
      TextButton(
        onPressed: () {
          onDelete.call();
          Navigator.pop(context);
        },
        child: const Text('Yes'),
      )
    ],
  );

  await showDialog<void>(
      context: context, builder: (BuildContext context) => dialog);
}
