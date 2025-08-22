import 'package:flutter/material.dart';
import 'background_themes.dart'; // Correct import

/// Background widget that applies different background colors to areas of the screen.
///
/// Uses a [BackgroundTheme] instance to provide colors for
/// appBar, body, and footer areas.
///
/// If you only want a simple full background, pass a unified color in the theme.
class Background extends StatelessWidget {
  final Widget child;
  final BackgroundTheme theme;

  const Background({required this.child, required this.theme, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: theme.body, child: child);
  }
}
