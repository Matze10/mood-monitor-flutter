import 'package:flutter/material.dart';

/// OverlayLogoWidget overlays a logo image above its child, centered and responsive.
/// Overlay color is now fully opaque and controlled by HomeScreen.
class OverlayWidget extends StatelessWidget {
  final Color? overlayColor;
  final String? logoAsset;
  final double? logoSize;
  final String? text;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  const OverlayWidget({
    super.key,
    this.overlayColor,
    this.logoAsset,
    this.logoSize,
    this.text,
    this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // If overlayColor is not set, use the current screen's background color
    final Color bgColor =
        overlayColor ?? Theme.of(context).scaffoldBackgroundColor;

    return Positioned.fill(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: bgColor,
          child: Stack(
            children: [
              if (logoAsset != null && logoSize != null)
                Center(
                  child: Image.asset(
                    logoAsset!,
                    height: logoSize, // Only set height
                    fit: BoxFit.contain,
                  ),
                ),
              if (text != null)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 12),
                    child: Text(
                      text!,
                      style:
                          textStyle ??
                          const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
