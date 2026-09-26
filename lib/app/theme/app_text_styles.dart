import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const textTheme = TextTheme(
    displaySmall: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 30,
      fontWeight: FontWeight.w800,
      height: 1.2,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.25,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.35,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.45,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 15,
      fontWeight: FontWeight.w700,
      height: 1.3,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 13,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
  );
}
