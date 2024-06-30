import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';
class  MyThemeData{
  static const Color primaryColor=Color(0xffDFECDB);
  static const Color primaryDarkColor=Color(0xff060E1E);
  static const Color secondColor=Color(0xff5D9CEC);
  static const Color secondDarkColor=Color(0xff5D9CEC);
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
          color: Colors.black
      ),
      bodySmall:  GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black
      ),
      displayMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.white
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
      backgroundColor: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: secondColor,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 30),
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.white
        )
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
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
          color: Colors.white
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
    scaffoldBackgroundColor: primaryDarkColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: secondDarkColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: secondDarkColor,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),
        elevation: 0,
        iconTheme:  IconThemeData(
            color: MyProvider().theme == ThemeMode.light ? Colors.white : Colors.black
        )
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    useMaterial3: true,
  );
}