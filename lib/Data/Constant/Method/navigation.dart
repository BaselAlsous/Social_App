import 'package:flutter/material.dart';

class Navigation {
  static navigationAndBack({
    required BuildContext context,
    required Widget page,
  }) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static navigationAndNotBack({
    required BuildContext context,
    required Widget page,
  }) {
    return Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }
}
