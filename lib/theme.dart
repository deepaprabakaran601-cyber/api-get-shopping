import 'package:flutter/material.dart';

bool isDarkMode = true;

Color bgColor = Color(0xFF121212);
Color cardColor = Colors.grey.shade900;
Color textColor = Colors.white;
Color subTextColor = Colors.white70;
Color appBarColor = Color(0xFF0D0D0D);

void toggleTheme() {
  isDarkMode = !isDarkMode;

  if (isDarkMode) {
    bgColor = Color(0xFF121212);
    cardColor = Colors.grey.shade900;
    textColor = Colors.white;
    subTextColor = Colors.white70;
    appBarColor = Color(0xFF0D0D0D);
  } else {
    bgColor = Colors.white;
    cardColor = Colors.grey.shade200;
    textColor = Colors.black;
    subTextColor = Colors.black54;
    appBarColor = Colors.white;
  }
}
