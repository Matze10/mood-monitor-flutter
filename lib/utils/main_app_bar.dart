import 'package:flutter/material.dart';

/// Builds the main app bar with configurable background, leading, and title.
PreferredSizeWidget buildMainAppBar({
  required Color backgroundColor,
  Widget? leading,
  Widget? title,
  List<Widget>? actions,
  double leadingPadding = 8.0, // <-- Add this parameter for dynamic control
}) {
  return AppBar(
    leading: leading != null
        ? Padding(
            padding: EdgeInsets.only(
              left: leadingPadding,
            ), // <-- Dynamic padding
            child: leading,
          )
        : null,
    title: title ?? const Text("The Bird's Bough"),
    centerTitle: true, // <-- Center the title
    backgroundColor: backgroundColor,
    actions: actions,
  );
}
