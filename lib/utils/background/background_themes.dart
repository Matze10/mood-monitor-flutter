import 'package:flutter/material.dart';

/// A model class to hold background colors for app sections and overlays.
///
/// Supports either:
/// - Unified color for all parts (if [unifiedColor] is set),
/// - Or individual colors for appBar, body, and footer.
/// - Overlay and underlay colors for canvas and notepad.
/// Accessors fallback to unifiedColor if individual colors are not provided.
class BackgroundTheme {
  /// Unified color for all areas (if set).
  final Color? unifiedColor;

  /// Individual colors for app bar, body, and footer.
  final Color? appBarColor;
  final Color? bodyColor;
  final Color? footerColor;

  /// Overlay backgrounds (fully opaque).
  final Color? overlayBackgroundColorCanvas;
  final Color? overlayBackgroundColorNotepad;

  /// Underlay backgrounds (slightly transparent).
  final Color? underlayBackgroundColorCanvas;
  final Color? underlayBackgroundColorNotepad;

  /// Constructor for BackgroundTheme.
  const BackgroundTheme({
    this.unifiedColor,
    this.appBarColor,
    this.bodyColor,
    this.footerColor,
    this.overlayBackgroundColorCanvas,
    this.overlayBackgroundColorNotepad,
    this.underlayBackgroundColorCanvas,
    this.underlayBackgroundColorNotepad,
  });

  /// Get color for app bar, fallback to [unifiedColor] or default.
  Color get appBar => appBarColor ?? unifiedColor ?? Colors.teal[50]!;

  /// Get color for main body, fallback to [unifiedColor] or default.
  Color get body => bodyColor ?? unifiedColor ?? Colors.teal[50]!;

  /// Get color for footer, fallback to [unifiedColor] or default.
  Color get footer => footerColor ?? unifiedColor ?? Colors.teal[50]!;

  /// Overlay backgrounds (fully opaque).
  Color get overlayCanvas =>
      overlayBackgroundColorCanvas ?? unifiedColor ?? Colors.teal[50]!;
  Color get overlayNotepad =>
      overlayBackgroundColorNotepad ?? unifiedColor ?? Colors.teal[50]!;

  /// Underlay backgrounds (slightly transparent).
  Color get underlayCanvas =>
      underlayBackgroundColorCanvas ??
      (unifiedColor != null
          ? unifiedColor!.withAlpha(46) // 46/255 ≈ 0.18 opacity
          : Colors.teal[50]!.withAlpha(46));
  Color get underlayNotepad =>
      underlayBackgroundColorNotepad ??
      (unifiedColor != null
          ? unifiedColor!.withAlpha(46)
          : Colors.teal[50]!.withAlpha(46));

  /// Creates a theme with all parts set to the same color.
  factory BackgroundTheme.unified(Color color) => BackgroundTheme(
    unifiedColor: color,
    overlayBackgroundColorCanvas: color,
    overlayBackgroundColorNotepad: color,
    underlayBackgroundColorCanvas: color.withAlpha(46),
    underlayBackgroundColorNotepad: color.withAlpha(46),
  );

  /// Creates a default theme with teal[50] backgrounds.
  factory BackgroundTheme.defaultTheme() =>
      BackgroundTheme.unified(Colors.teal[50]!);

  /// Creates a sample split theme with different colors.
  factory BackgroundTheme.sampleSplit() => BackgroundTheme(
    appBarColor: Colors.teal,
    bodyColor: Colors.tealAccent,
    footerColor: Colors.tealAccent,
    overlayBackgroundColorCanvas: Colors.teal,
    overlayBackgroundColorNotepad: Colors.tealAccent,
    underlayBackgroundColorCanvas: Colors.teal.withAlpha(46),
    underlayBackgroundColorNotepad: Colors.tealAccent.withAlpha(46),
  );
}
