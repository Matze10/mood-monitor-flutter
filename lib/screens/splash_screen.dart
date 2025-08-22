import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../utils/footer.dart'; // Import the reusable footer widget
import '../utils/colors/app_colors.dart'; // <-- Centralized colors
import '../utils/text/text_styles.dart'; // <-- Centralized text styles

/// SplashScreen widget displays a logo, curved app name, and version info.
/// After a short delay, it navigates to the HomeScreen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// State for SplashScreen, handles navigation and layout
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 15 seconds, then navigate to HomeScreen
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted) {
        Logger('SplashScreen').info('Navigating to HomeScreen');
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Logger('SplashScreen').info('SplashScreen build called');
    // --- MediaQuery setup for responsive layout ---
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double logoWidth = screenWidth * 0.42;
    final double logoHeight = screenHeight * 0.42;

    return Scaffold(
      backgroundColor:
          AppColors.splashBackground, // <-- Use centralized background color
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo at the top
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.14),
              child: Center(
                child: Image.asset(
                  'assets/images/logo_splash.png',
                  width: logoWidth,
                  height: logoHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // App name text
            Center(
              child: Text(
                "The Bird's Bough",
                style: AppTextStyles.splashText.copyWith(
                  fontSize: screenWidth * 0.09,
                  fontWeight: FontWeight.bold,
                  color: AppColors.splashText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      // Footer widget displays the app version at the bottom
      bottomNavigationBar: const Footer(),
    );
  }
}
