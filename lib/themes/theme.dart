import 'package:flutter/material.dart';

final ThemeData mytheme = ThemeData(
  fontFamily: 'Inter',
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
);

abstract class ThemeStyle {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
  static const TextStyle subTitleStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
  static const TextStyle cardText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );
  static const TextStyle cardTimeText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
  static const TextStyle warningText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
  );
  static const TextStyle buttonText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

abstract class AppColors {
  static const Color primary = Color(0xFF3C98FF);
  static const Color lowPriority = Color(0xFFC6FED2);
  static const Color highPriority = Color(0xFFFF9D9D);
  static const Color normalPriority = Color(0xFFC6CBFE);
  static const Color textColor = Color(0xFF464646);
  static const Color background = Color(0xFFF8F8F8);
}
