import 'package:flutter/material.dart';

final ThemeData mytheme = ThemeData(
  fontFamily: 'Jost',
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: AppColors.primary,
  ),
);

abstract class ThemeStyle {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24.0,
    color: AppColors.textColor,
  );
  static const TextStyle subTitleStyle = TextStyle(
    fontSize: 18.0,
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
    color: AppColors.softBlue,
  );
  static const TextStyle buttonCancelText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}

abstract class AppColors {
  static const Color primary = Color(0xFF1253E8);
  static const Color softBlue = Color(0xFFDBFBFF);
  static const Color lowPriority = Color(0xFFF2CB05);
  static const Color highPriority = Color(0xFFF21616);
  static const Color normalPriority = Color(0xFF04B2D9);
  static const Color textColor = Color(0xFF0D0D0D);
  static const Color background = Colors.white;
  static const Color cancelButton = Color(0xFFA7E7F6);
  static const Color deleteColor = Color(0xFF034C8C);
}
