import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData? lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleSpacing: 10.0.sp,
      titleTextStyle: GoogleFonts.lobster(
        color: Colors.black,
        fontSize: 22.0.sp,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
  );
}
