import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        primary: Color(0xff57cc99),
        secondary: Color(0xff80ed99),
        tertiary: Color(0xffc7f9cc),
        background: Color(0xffedede9),
        onPrimary: Color(0xff162149),
        onSecondary: Color(0xff2A0834),
        onBackground: Color(0xff22577a),
        onTertiary: Color(0xff181818),
        outline: Color(0xff1b263b),
        error: Color(0xffbc4749),
        surface: Color(0xFF17203A)),
    fontFamily: 'Montserrat',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff57cc99),
        foregroundColor: const Color(0xff162149),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ));

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      primary: Color(0xffe3e3e3),
      secondary: Color(0xff80ed99),
      tertiary: Color(0xffc7f9cc),
      background: Colors.black,
      onPrimary: Color(0xff162149),
      onSecondary: Color(0xff2A0834),
      onBackground: Color(0xff22577a),
      onTertiary: Color(0xff181818),
      outline: Color(0xff1b263b),
      error: Color(0xffbc4749),
      surface: Color(0xFF17203A)),
  fontFamily: 'Montserrat',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff57cc99),
      foregroundColor: const Color(0xff162149),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);
