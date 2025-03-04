import 'dart:math';
import 'package:flutter/material.dart';

const principalColor = Color.fromARGB(255, 128, 0, 128); // Purple
const secondaryColor = Color.fromARGB(255, 186, 85, 211); // Medium Orchid
const tertiaryColor = Color.fromARGB(255, 218, 112, 214); // Orchid
const backgroundColor = Color.fromARGB(255, 230, 230, 250); // Lavender
const surfaceColor = Color.fromARGB(255, 221, 160, 221); // Plum
const errorColor = Color.fromARGB(255, 255, 105, 180); // Hot Pink
const onPrimaryColor = Color.fromARGB(255, 255, 182, 193); // Light Pink
const onSecondaryColor = Color.fromARGB(255, 255, 192, 203); // Pink

const ColorScheme colorScheme = ColorScheme(
  primary: Colors.black87,
  secondary: principalColor,
  surface: principalColor,
  onSurface: Colors.black,
  error: Colors.deepOrange,
  onPrimary: principalColor,
  onSecondary: Colors.deepOrange,
  surfaceContainerHighest: Colors.deepOrange,
  onError: Colors.deepOrange,
  brightness: Brightness.light,
);

final List<Color> colorList = [
  principalColor,
  secondaryColor,
  tertiaryColor,
  backgroundColor,
  surfaceColor,
  errorColor,
  onPrimaryColor,
  onSecondaryColor,
];

Color getRandomColor() {
  final random = Random();
  final filteredColorList =
      colorList.where((color) => color != backgroundColor).toList();
  return filteredColorList[random.nextInt(filteredColorList.length)];
}
