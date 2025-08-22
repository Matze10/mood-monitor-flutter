import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontFamily: 'OpenSans', // Use Open Sans
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'OpenSans', // Use Open Sans
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'OpenSans', // Use Open Sans
    fontWeight: FontWeight.bold,
    color: AppColors.buttonText,
  );

  // --- SplashScreen specific ---
  static const TextStyle splashArc = TextStyle(
    fontFamily: 'PermanentMarker',
    fontSize: 32,
    color: AppColors.splashArc,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );

  static const TextStyle splashText = TextStyle(
    fontFamily: 'OpenSans', // Use Open Sans
    fontSize: 24,
    color: AppColors.splashText,
    fontWeight: FontWeight.w600,
  );
}
