import 'package:flutter/material.dart';

/// Shows a snackbar with [text] from [context].
void snackbar(BuildContext context, String text) {
  Scaffold.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}

/// Shows a bottomsheet with [content] from [context].
void bottomsheet(BuildContext context, Widget content) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (_) => content,
  );
}
