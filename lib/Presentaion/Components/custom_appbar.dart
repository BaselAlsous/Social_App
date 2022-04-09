import 'package:flutter/material.dart';

PreferredSizeWidget customeAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? action,
  
}) {
  return AppBar(
    title: Text(title),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: action,
  );
}
