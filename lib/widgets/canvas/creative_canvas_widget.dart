import 'package:flutter/material.dart';

/// CreativeCanvasWidget displays a placeholder for drawing, uploading, or setting a template.
/// In the future, this can be expanded to a full creative mode.
class CreativeCanvasWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLocked;

  const CreativeCanvasWidget({super.key, this.onTap, this.isLocked = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: const Center(
        child: Text("🖌️ Draw, Upload, or Set Template Here"),
      ),
    );
  }
}
