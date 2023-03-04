import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/core/presentation/style/palette.dart';

class DarkTheme {
  static final theme = ThemeData(
    scaffoldBackgroundColor: Palette.black,
    cardColor: Palette.black800,
    appBarTheme: const AppBarTheme(
        color: Palette.black,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent)),
    dialogBackgroundColor: Palette.black800,
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Palette.white)),
    inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.fieldDecorationBorder)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.fieldDecorationBorder)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.fieldDecorationBorder)),
        hintStyle: TextStyle(color: Palette.hint)),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Palette.mainColor),
            foregroundColor: MaterialStateProperty.all(Palette.white),
            textStyle:
                const MaterialStatePropertyAll(TextStyle(color: Palette.white)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0))))),
  );
}
