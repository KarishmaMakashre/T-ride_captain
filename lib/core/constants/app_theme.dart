import 'package:flutter/material.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
// Light Theme
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.primaryLight,
    surface: AppColors.white,
    background: AppColors.background,
    error: AppColors.error,
    onPrimary: AppColors.white,
    onSecondary: AppColors.primary,
    onSurface: AppColors.textPrimary,
    onBackground: AppColors.textPrimary,
    onError: AppColors.white,
  ),
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
    titleLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
  ),
  // Fix yahan: CardThemeData use karo
  cardTheme: CardThemeData( // CardTheme se change kiya
    color: AppColors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
// Dark Theme (same fix)
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryDark,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryDark,
    secondary: AppColors.primary,
    surface: AppColors.backgroundDark,
    background: AppColors.backgroundDark,
    error: AppColors.error,
    onPrimary: AppColors.primaryDark, // Adjusted for better contrast in dark mode
    onSecondary: AppColors.primary,
    onSurface: AppColors.textSecondary,
    onBackground: AppColors.textSecondary,
    onError: AppColors.white,
  ),
  scaffoldBackgroundColor: AppColors.backgroundDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundDark,
    foregroundColor: AppColors.textSecondary,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textSecondary),
    bodyMedium: TextStyle(color: AppColors.textLight),
    titleLarge: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold),
  ),
  // Fix yahan bhi
  cardTheme: CardThemeData( // CardTheme se change kiya
    color: AppColors.backgroundDark,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);