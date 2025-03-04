import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: colorScheme,
  textTheme: TextTheme(),
  primaryColor: Colors.black12,
  scaffoldBackgroundColor: backgroundColor,
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
    backgroundColor: WidgetStatePropertyAll<Color>(Colors.black87),
  )),
);
