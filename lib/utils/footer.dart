// footer.dart
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// A reusable footer widget that displays the app version.
/// Place this in the `bottomNavigationBar` of your Scaffold for a persistent footer.
class Footer extends StatelessWidget {
  final Color? backgroundColor; // <-- Add this line

  const Footer({
    super.key,
    this.backgroundColor,
  }); // <-- Add backgroundColor to constructor

  Future<String> _getVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      // Format: v1.2.3+4 (version+build number)
      return 'v${info.version}+${info.buildNumber}';
    } catch (e) {
      // Fallback in case of error
      return 'Version unavailable';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: FutureBuilder<String>(
          future: _getVersion(),
          builder: (context, snapshot) {
            String text;
            if (snapshot.connectionState == ConnectionState.waiting) {
              text = 'Loading version...';
            } else if (snapshot.hasError) {
              text = 'Version unavailable';
            } else {
              text = snapshot.data ?? 'Version unavailable';
            }
            return IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                color: backgroundColor, // <-- Use the backgroundColor here
                child: Text(
                  text,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
