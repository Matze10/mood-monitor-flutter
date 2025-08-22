import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(
    0xFF008080,
  ); // Main accent color (used for app bar, highlights)
  static const Color accent = Color(
    0xFF00BFAE,
  ); // Secondary accent color (used for highlights, icons)
  static const Color button = Color(0xFF008080); // Button background color
  static const Color buttonText = Colors.white; // Button text/icon color
  static const Color background = Color(
    0xFFE0F2F1,
  ); // Main app background color
  static const Color footer = Color(0xFFB2DFDB); // Footer background color

  // AppBar
  static const Color appBar = Color(0xFF008080); // App bar background color

  // --- SplashScreen specific ---
  static const Color splashBackground = Color(
    0xFF234BCC,
  ); // Splash background (override if needed)
  static const Color splashText = Color(0xFF000000); // Splash main text color
  static const Color splashArc = Color(0xFF00BFAE); // Splash arc text color
  // Add more if needed

  // Error, Success, Warning
  static const Color error = Color(0xFFD32F2F); // Error messages, error states
  static const Color success = Color(
    0xFF388E3C,
  ); // Success messages, confirmations
  static const Color warning = Color(0xFFFBC02D); // Warning messages, alerts

  // Text colors
  static const Color textPrimary = Color(0xFF222222); // Main text color
  static const Color textSecondary = Color(
    0xFF757575,
  ); // Secondary text color (subtle, less important)
  static const Color textDisabled = Color(0xFFBDBDBD); // Disabled text color

  // Overlay and underlay (example values)
  static const Color overlayCanvas = Color(
    0xFFFFFFFF,
  ); // Canvas overlay background (white)
  static const Color overlayNotepad = Color(
    0xFFF5F5F5,
  ); // Notepad overlay background (light gray)
  static const Color underlayCanvas = Color(
    0x2E008080,
  ); // Canvas underlay (teal, 18% opacity)
  static const Color underlayNotepad = Color(
    0x2EF5F5F5,
  ); // Notepad underlay (light gray, 18% opacity)

  // Border colors
  static const Color border =
      Colors.black; // Default border color (used for containers, cards, etc.)
  static const Color borderLight = Color(
    0xFFBDBDBD,
  ); // Light border color (optional, for subtle borders)
}
