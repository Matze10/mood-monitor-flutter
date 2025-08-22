import 'package:flutter/material.dart';
import '../../utils/buttons/round_button.dart';

/// LogoButton is a reusable button that displays a logo/image inside.
/// By default, it is round (using RoundButton), but you can later
/// extend this to support other shapes (e.g., square) if needed.
class LogoButton extends StatelessWidget {
  final String assetPath; // Path to the logo/image asset
  final double size; // Diameter of the button
  final VoidCallback? onPressed; // Tap callback
  final Color? backgroundColor; // Optional background color

  const LogoButton({
    super.key,
    required this.assetPath,
    this.size = 40,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Uses RoundButton for round shape; can swap for other shapes later
    return RoundButton(
      size: size,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black, // Black frame
            width: 2.0, // Thickness of the frame
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(size * 0.15), // 10% padding, scales with size
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
