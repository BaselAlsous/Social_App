import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static ThemeData? lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[50],
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
    textTheme: TextTheme(
      //--------------------- Header Text ---------------------//

      headline1: GoogleFonts.roboto(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18.0.sp,
      ),
      headline2: GoogleFonts.roboto(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 17.0.sp,
      ),
      headline3: GoogleFonts.roboto(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 16.0.sp,
      ),
      headline4: GoogleFonts.roboto(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 15.0.sp,
      ),
      headline5: GoogleFonts.roboto(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 14.0.sp,
      ),
      headline6: GoogleFonts.roboto(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 13.0.sp,
      ),

      //--------------------- Body Text ---------------------//

      bodyText1: GoogleFonts.roboto(
        color: Colors.black87,
        fontSize: 14.0.sp,
      ),
      bodyText2: GoogleFonts.roboto(
        color: Colors.black87,
        fontSize: 13.0.sp,
      ),

      //--------------------- Button Text ---------------------//

      button: GoogleFonts.roboto(
        color: Colors.white,
        fontStyle: FontStyle.italic,
        fontSize: 13.0.sp,
      ),

      caption: GoogleFonts.roboto(
        color: Colors.grey,
        fontSize: 14.0.sp,
      ),
      // ),
    ),
  );
}
