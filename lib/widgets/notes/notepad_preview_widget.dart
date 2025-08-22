import 'package:flutter/material.dart';
import '../../utils/lock_stage_handler.dart';
import '../../utils/buttons/lock_button.dart';
import '../../utils/text/text_styles.dart';
import '../notes/notepad_widget.dart';
import '../overlay/overlay_widget.dart';

/// NotepadPreviewWidget
/// Shows a preview of notes, manages its own lock state and overlay.
/// Exposes onUnlock and onEdit callbacks. Accepts a TextEditingController.
class NotepadPreviewWidget extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onUnlock;
  final VoidCallback? onEdit;
  final VoidCallback? onRelock;
  final String? logoAsset;
  final double logoSize;
  final Color overlayColor;
  final String? unlockText;

  const NotepadPreviewWidget({
    super.key,
    required this.controller,
    this.onUnlock,
    this.onEdit,
    this.onRelock,
    this.logoAsset,
    required this.logoSize,
    required this.overlayColor,
    this.unlockText,
  });

  @override
  State<NotepadPreviewWidget> createState() => NotepadPreviewWidgetState();
}

class NotepadPreviewWidgetState extends State<NotepadPreviewWidget> {
  final LockStageHandler _lockHandler = LockStageHandler();

  void relock() {
    _lockHandler.lock();
    if (widget.onRelock != null) widget.onRelock!();
  }

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
              child: NotepadWidget(
                controller: widget.controller,
                isLocked: _lockHandler.locked,
                hintText: 'Write notes here throughout the day...',
              ),
            ),
            if (_lockHandler.locked)
              OverlayWidget(
                overlayColor: widget.overlayColor,
                logoAsset: widget.logoAsset,
                logoSize: widget.logoSize,
                text: null,
                onTap: () {
                  _lockHandler.unlock();
                  if (widget.onUnlock != null) widget.onUnlock!();
                },
              ),
            if (!_lockHandler.locked && widget.controller.text.isEmpty)
              Positioned(
                top: 16,
                left: 16,
                child: Text(
                  "Tap to Start",
                  style: AppTextStyles.body.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (!_lockHandler.locked)
              Positioned(
                top: 0,
                right: 0,
                child: LockButton(locked: false, onPressed: relock),
              ),
          ],
        );
      },
    );
  }
}
