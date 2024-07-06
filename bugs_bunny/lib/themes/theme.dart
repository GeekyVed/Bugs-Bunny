import 'package:flutter/material.dart';

ThemeData cyberDarkTheme() {
  final base = ThemeData.dark();
  final colorScheme = ColorScheme.fromSeed(seedColor: Color(0xff00ffcc));

  return base.copyWith(
    colorScheme: colorScheme,
    primaryColor: colorScheme.primary,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      titleTextStyle: TextStyle(color: colorScheme.onSurface, fontSize: 20),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 86, 193, 44),
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        fixedSize: Size(double.infinity, 60)
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: colorScheme.onPrimary, fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: colorScheme.onPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: colorScheme.onPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: colorScheme.onPrimary, fontSize: 14),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.onSurface),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.onSurface),
        borderRadius: BorderRadius.circular(10),
      ),
      labelStyle: TextStyle(color: colorScheme.onSurface),
      hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
    ),
    iconTheme: IconThemeData(color: colorScheme.onPrimary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
  );
}
