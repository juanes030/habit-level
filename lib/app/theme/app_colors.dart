import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFF176B5B);
  static const secondary = Color(0xFFD99B37);
  static const success = Color(0xFF277A52);
  static const darkSuccess = Color(0xFF72C792);
  static const warning = Color(0xFF94600C);
  static const error = Color(0xFFB5423A);
  static const disabled = Color(0xFFA6B1AB);

  static const lightBackground = Color(0xFFF4F7F5);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightTextPrimary = Color(0xFF19231F);
  static const lightTextSecondary = Color(0xFF5F7068);
  static const lightOutline = Color(0xFFD9E2DD);

  static const darkBackground = Color(0xFF101915);
  static const darkSurface = Color(0xFF1B2620);
  static const darkTextPrimary = Color(0xFFEDF4EF);
  static const darkTextSecondary = Color(0xFFB0BDB6);
  static const darkOutline = Color(0xFF53635B);

  static final lightScheme =
      ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: primary,
        onPrimary: Colors.white,
        primaryContainer: const Color(0xFFD4EFE5),
        onPrimaryContainer: const Color(0xFF123C32),
        secondary: secondary,
        onSecondary: lightTextPrimary,
        surface: lightSurface,
        onSurface: lightTextPrimary,
        error: error,
        onError: Colors.white,
        outline: lightOutline,
      );

  static final darkScheme =
      ColorScheme.fromSeed(
        seedColor: const Color(0xFF72C7A5),
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color(0xFF72C7A5),
        onPrimary: const Color(0xFF05291F),
        primaryContainer: const Color(0xFF255A49),
        onPrimaryContainer: const Color(0xFFDBF5E9),
        secondary: const Color(0xFFE6B854),
        onSecondary: const Color(0xFF2C210A),
        surface: darkSurface,
        onSurface: darkTextPrimary,
        error: const Color(0xFFF28B82),
        onError: const Color(0xFF3B0908),
        outline: darkOutline,
      );
}
