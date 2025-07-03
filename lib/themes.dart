import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/constants.dart';

class AppTheme {
  // ignore: long-method
  static ThemeData get lightTheme {
    final base = ThemeData.light();

    return base.copyWith(
      primaryColor: kPrimaryColor3,
      scaffoldBackgroundColor: kBackgroundColor3,
      colorScheme: const ColorScheme.light(
        primary: kPrimaryColor3,
        secondary: Colors.lightBlue, // замена для accentColor
        surface: Colors.white,
        background: Colors.white, // замена для backgroundColor
        shadow: Colors.grey,
        inversePrimary: Colors.black,
      ),
      iconTheme: const IconThemeData(color: kBodyTextColorLight),
      primaryIconTheme: const IconThemeData(color: Colors.blue),
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        bodyMedium: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1,
        ),
        bodyLarge: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1,
        ),
        displayMedium: const TextStyle(
          color: kBodyTextColorLight,
          fontSize: 32,
        ),
        displayLarge: const TextStyle(color: Colors.blue, fontSize: 80),
      ),
    );
  }

  // ignore: long-method
  static ThemeData get darkTheme {
    final base = ThemeData.dark();

    return base.copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kBackgroundDarkColor22,
      colorScheme: ColorScheme.dark(
        // Изменено на dark()
        primary: kPrimaryColor,
        secondary: Colors.red, // замена для accentColor
        surface: kSurfaceDarkColor,
        background: kBackgroundDarkColor, // замена для backgroundColor
        shadow: Colors.black,
        inversePrimary: Colors.white,
      ),
      iconTheme: const IconThemeData(color: kBodyTextColorDark),
      primaryIconTheme: const IconThemeData(color: Colors.white),
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        bodyMedium: const TextStyle(
          color: kBodyTextColorLight,
          fontSize: 15,
          height: 1,
        ),
        bodyLarge: const TextStyle(
          color: kBodyTextColorLight,
          fontSize: 15,
          height: 1,
        ),
        displayMedium: const TextStyle(
          color: kBodyTextColorLight,
          fontSize: 32,
        ),
        displayLarge: const TextStyle(color: Colors.blue, fontSize: 80),
      ),
    );
  }
}
