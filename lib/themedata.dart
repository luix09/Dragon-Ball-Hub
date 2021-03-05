import 'package:flutter/material.dart';

ThemeData myAppTheme = buildTheme();

ThemeData buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      primaryColor: Colors.amber,
      primaryColorDark: Colors.orangeAccent,
      hintColor: Colors.grey
  );
}