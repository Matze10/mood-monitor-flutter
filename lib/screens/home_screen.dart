import 'package:flutter/material.dart';

import '../utils/colors/app_colors.dart';
import '../utils/buttons/app_button.dart';
import '../utils/text/text_styles.dart';
import '../utils/footer.dart';
import '../utils/background/background.dart';
import '../utils/background/background_themes.dart';
import '../utils/main_app_bar.dart';
import '../utils/buttons/lock_button.dart';
import '../widgets/common/date_picker_row.dart';
import '../widgets/canvas/creative_canvas_preview_widget.dart';
import '../widgets/notes/notepad_preview_widget.dart';
import '../widgets/notes/notepad_widget.dart';
import '../widgets/common/logo_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Overlay and logo assets
  String? _overlayImageAsset = 'assets/images/logo_notes.png';
  String? _creativeLogoAsset = 'assets/images/logo_canvas.png';

  // Controllers for notes and mood
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _moodController = TextEditingController();
  DateTime _selectedMoodDate = DateTime.now();

  // Use a unified background theme for the whole screen
  final BackgroundTheme _theme = BackgroundTheme.unified(AppColors.background);

  // GlobalKey to control NotepadPreviewWidget's state for relocking
  final GlobalKey<NotepadPreviewWidgetState> _notepadPreviewKey =
      GlobalKey<NotepadPreviewWidgetState>();

  bool _showEditor = false;

  void _openMoodDialog() {
    showDialog(
      context: context,
      builder: (context) {
        DateTime tempDate = _selectedMoodDate;
        TextEditingController tempMoodController = TextEditingController(
          text: _moodController.text,
        );
        return AlertDialog(
          title: Text('New Mood Entry', style: AppTextStyles.heading),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DatePickerRow(
                selectedDate: tempDate,
                onDateChanged: (date) {
                  tempDate = date;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: tempMoodController,
                decoration: InputDecoration(
                  labelText: 'How do you feel?',
                  labelStyle: AppTextStyles.body,
                  border: const OutlineInputBorder(),
                ),
                style: AppTextStyles.body,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: AppTextStyles.body),
            ),
            AppButton(
              label: 'Save',
              onPressed: () {
                setState(() {
                  _selectedMoodDate = tempDate;
                  _moodController.text = tempMoodController.text;
                });
                Navigator.of(context).pop();
              },
              icon: Icons.save,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Responsive values
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.05;
    final double verticalPadding = MediaQuery.of(context).size.height * 0.02;

    /// final double fontSize = MediaQuery.of(context).size.width * 0.04;
    final double logoSizeCanvas = MediaQuery.of(context).size.height * 0.185;
    final double logoSizeNotes = MediaQuery.of(context).size.height * 0.30;

    return Scaffold(
      backgroundColor: _theme.body,
      appBar: buildMainAppBar(
        backgroundColor: _theme.appBar,
        leading: LogoButton(
          assetPath: 'assets/images/logo_main.png',
          size: 56,
          onPressed: () {},
        ),
        leadingPadding: 10.0,
      ),
      body: Background(
        theme: _theme,
        child: SafeArea(
          child: Stack(
            children: [
              // Main content (previews, etc.)
              Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // --- Creative Canvas Preview ---
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              verticalPadding,
                              horizontalPadding,
                              0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _theme.body,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: AppColors.border,
                                  width: 2,
                                ),
                              ),
                              child: CreativeCanvasPreviewWidget(
                                logoAsset: _creativeLogoAsset,
                                logoSize: logoSizeCanvas,
                                overlayColor: _theme.overlayCanvas,
                                onUnlock: () {},
                                onEdit: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Creative editor coming soon!',
                                        style: AppTextStyles.body,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // --- Notepad Preview ---
                        const SizedBox(height: 16),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _theme.body,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: AppColors.border,
                                  width: 2,
                                ),
                              ),
                              child: NotepadPreviewWidget(
                                key: _notepadPreviewKey,
                                controller: _notesController,
                                logoAsset: _overlayImageAsset,
                                logoSize: logoSizeNotes,
                                overlayColor: _theme.overlayNotepad,
                                onUnlock: () {},
                                onRelock: () {
                                  _notepadPreviewKey.currentState?.relock();
                                },
                                onEdit: () {
                                  setState(() => _showEditor = true);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // --- Main action button ---
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        label: "New Mood Entry",
                        onPressed: _openMoodDialog,
                        icon: Icons.add,
                      ),
                    ),
                  ),
                  // --- Footer ---
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Footer(backgroundColor: _theme.footer),
                  ),
                ],
              ),
              // --- Overlay Notepad Editor (full screen except app bar & footer) ---
              if (_showEditor)
                Positioned.fill(
                  child: Material(
                    color: Colors.white, // No opacity!
                    child: SafeArea(
                      child: Stack(
                        children: [
                          // Notepad editor content
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: NotepadWidget(
                              controller: _notesController,
                              isLocked: false,
                              hintText:
                                  "Write notes here throughout the day...",
                            ),
                          ),
                          // Top right: lock and X
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Unlocked lock button (calls relock)
                                LockButton(
                                  locked: false,
                                  onPressed: () {
                                    setState(() => _showEditor = false);
                                    _notepadPreviewKey.currentState?.relock();
                                  },
                                ),
                                // X button (just closes editor, stays unlocked)
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                  onPressed: () =>
                                      setState(() => _showEditor = false),
                                  tooltip: 'Close',
                                ),
                              ],
                            ),
                          ),
                        ],
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
