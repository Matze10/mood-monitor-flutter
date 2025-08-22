import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NotepadWidget extends StatefulWidget {
  final QuillController? quillController;
  final TextEditingController?
  controller; // Optional sync for legacy plain text
  final bool isLocked; // Lock editor and toolbar if true
  final String? hintText; // Hint text when empty

  const NotepadWidget({
    super.key,
    this.quillController,
    this.controller,
    this.isLocked = false,
    this.hintText,
  });

  @override
  State<NotepadWidget> createState() => _NotepadWidgetState();
}

class _NotepadWidgetState extends State<NotepadWidget> {
  late final QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.quillController ?? QuillController.basic();

    // Sync legacy plain-TextEditingController if provided
    if (widget.controller != null) {
      _controller.addListener(() {
        final plain = _controller.document.toPlainText();
        if (widget.controller!.text != plain) {
          widget.controller!.text = plain;
        }
      });
    }
  }

  bool get _isDocEmpty => _controller.document.toPlainText().trim().isEmpty;

  @override
  Widget build(BuildContext context) {
    _controller.readOnly = widget.isLocked;
    return Column(
      children: [
        // ❗ Show toolbar only if editing is allowed
        if (!widget.isLocked)
          QuillSimpleToolbar(
            controller: _controller,
            config: const QuillSimpleToolbarConfig(
              showBoldButton: true,
              showItalicButton: true,
              showUnderLineButton: true,
              showListNumbers: true,
              showListBullets: true,
              showColorButton: true,
              showUndo: true,
              showRedo: true,
            ),
          ),

        // Expanded editor area (fills remaining vertical space)
        Expanded(
          child: Stack(
            children: [
              QuillEditor.basic(
                controller: _controller,
                config:
                    const QuillEditorConfig(), // Required as of v11.4.2 :contentReference[oaicite:1]{index=1}
              ),

              // 📝 Hint overlay when empty AND read-only
              if (widget.isLocked && _isDocEmpty && widget.hintText != null)
                IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.hintText!,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
