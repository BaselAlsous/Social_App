import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

customToast({
  required String msg,
  required Color backgroundColor,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: Colors.white,
    fontSize: 16.0.sp,
  );
}
