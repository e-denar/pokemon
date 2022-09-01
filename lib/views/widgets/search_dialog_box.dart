import 'package:flutter/material.dart';

void showSearchDialogBox(BuildContext context, Function(String) onSearch) {
  final TextEditingController controller = TextEditingController();
  final AlertDialog dialog = AlertDialog(
    title: const Text('Search'),
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
          onSearch.call(controller.value.text);
          Navigator.pop(context);
        },
        child: const Text('Search'),
      )
    ],
  );

  showDialog<void>(context: context, builder: (BuildContext context) => dialog);
}
