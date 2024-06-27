import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class  MyThemeData{
  static const Color primaryColor=Color(0xffDFECDB);
  static const Color secondColor=Color(0xff5D9CEC);
  static const Color primaryDarkColor=Color(0xff060E1E);
  static ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: secondColor
      ),
      bodyMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: secondColor
      ),
      bodySmall:  GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black
      ),
      displayMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: primaryColor
      ),
      displaySmall: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black
      ),
      displayLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 30
      ),
    ),
    scaffoldBackgroundColor: primaryColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: secondColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: secondColor,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: secondColor,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 30),
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black
        )
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: secondColor),
    useMaterial3: true,
  );


  static ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.white
      ),
      displayMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: primaryDarkColor
      ),
      displaySmall: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.white
      ),
      bodyMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white
      ),
      bodySmall:  GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.white
      ),
      displayLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white
      ),
    ),
    scaffoldBackgroundColor: Colors.transparent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xffFACC1D),
      unselectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff141A2E),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.white
        )
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffDFECDB)),
    useMaterial3: true,
  );
}