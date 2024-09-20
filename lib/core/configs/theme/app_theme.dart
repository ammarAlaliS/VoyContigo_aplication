// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quickcar_aplication/core/configs/theme/app_colors.dart';

class AppTheme {
  // Tema claro
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.primaryText),
      bodyMedium: TextStyle(color: AppColors.secondaryText),
      headlineLarge: TextStyle(color: AppColors.primary),
      headlineMedium: TextStyle(color: AppColors.secondary),
      // Agrega más estilos según lo necesites
    ),
  );

  // Tema oscuro
  static final darkTheme = ThemeData(
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkPrimaryText), // Texto normal en modo oscuro
      bodyMedium: TextStyle(color: AppColors.darkSecondaryText), // Texto secundario en modo oscuro
      headlineLarge: TextStyle(color: AppColors.darkPrimary), // Títulos grandes en modo oscuro
      headlineMedium: TextStyle(color: AppColors.darkSecondary), // Títulos medios en modo oscuro
      // Agrega más estilos según lo necesites
    ),
  );
}
