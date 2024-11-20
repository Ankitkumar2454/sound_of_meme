import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme() => ThemeData(
        brightness: Brightness.light,
        // primaryColor: Colors.green,
        appBarTheme: AppBarTheme(
          color: Colors.white38,
        ),
      );
  static ThemeData darkTheme() => ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
      );
}
