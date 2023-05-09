import 'package:flutter/material.dart';

showMessage(String textContent, List<Widget>? actions, BuildContext context,
    [String? title]) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(textContent),
        actions: actions,
      );
    },
  );
}
