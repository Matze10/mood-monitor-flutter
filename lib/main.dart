import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'package:logging/logging.dart';

void main() {
  // Set up logging (use Logger instead of print for production)
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // You can send logs to a file, server, or external service here
    // For now, just print to console (remove or redirect in production)
    // ignore: avoid_print
    print('[${record.level.name}] ${record.time}: ${record.message}');
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    Logger('FlutterError').severe(
      'Flutter Error: \\${details.exception}\\nStack trace:\\n${details.stack}',
      details.exception,
      details.stack,
    );
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "The Bird's Bough",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Show splash screen first
      routes: {'/home': (context) => const HomeScreen()},
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        quill.FlutterQuillLocalizations.delegate, // Required for flutter_quill v11+
      ],
      supportedLocales: const [
        Locale('en'), // Add more locales if needed
      ],
    );
  }
}
