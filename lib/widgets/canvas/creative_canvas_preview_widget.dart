import 'package:flutter/material.dart';
import '../../utils/lock_stage_handler.dart';
import '../../utils/buttons/lock_button.dart';
import '../overlay/overlay_widget.dart';
import 'creative_canvas_widget.dart';

/// CreativeCanvasPreviewWidget
/// Shows a preview of the creative canvas, manages its own lock state and overlay.
/// Exposes onUnlock and onEdit callbacks.
class CreativeCanvasPreviewWidget extends StatefulWidget {
  final VoidCallback? onUnlock;
  final VoidCallback? onEdit;
  final String? logoAsset;
  final double logoSize;
  final Color overlayColor;
  final String? unlockText;

  const CreativeCanvasPreviewWidget({
    super.key,
    this.onUnlock,
    this.onEdit,
    this.logoAsset,
    required this.logoSize,
    required this.overlayColor,
    this.unlockText,
  });

  @override
  State<CreativeCanvasPreviewWidget> createState() =>
      _CreativeCanvasPreviewWidgetState();
}

class _CreativeCanvasPreviewWidgetState
    extends State<CreativeCanvasPreviewWidget> {
  final LockStageHandler _lockHandler = LockStageHandler();

  @override
  Widget build(BuildContext context) {
    // Use AnimatedBuilder for ChangeNotifier
    return AnimatedBuilder(
      animation: _lockHandler, // <-- listen to changes
      builder: (context, _) {
        return Stack(
          children: [
            GestureDetector(
              onTap: _lockHandler.locked ? null : widget.onEdit,
              child: CreativeCanvasWidget(
                isLocked: _lockHandler.locked,
                onTap: () {
                  if (!_lockHandler.locked && widget.onEdit != null)
                    widget.onEdit!();
                },
              ),
            ),
            if (_lockHandler.locked)
              OverlayWidget(
                overlayColor: widget.overlayColor,
                logoAsset: widget.logoAsset,
                logoSize: widget.logoSize,
                text: widget.unlockText ?? 'Tap to start',
                onTap: () {
                  _lockHandler.unlock();
                  if (widget.onUnlock != null) widget.onUnlock!();
                },
              ),
            if (!_lockHandler.locked)
              Positioned(
                top: 0,
                right: 0,
                child: LockButton(locked: false, onPressed: _lockHandler.lock),
              ),
          ],
        );
      },
    );
  }
}
