import 'package:flutter/material.dart';
import 'package:habita/core/theme/app_theme.dart';
import 'package:habita/presentation/screens/home/home_screen.dart';
import 'package:habita/presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(const HabitaApp());
}

class HabitaApp extends StatelessWidget {
  const HabitaApp({super.key});

  // Optional: provide a custom seed color here if you want to override default
  final Color? initialSeedColor = null; // e.g. Color(0xFF8AB6F9);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habita',
      debugShowCheckedModeBanner: false,
      // CALL the functions so they return ThemeData objects:
      theme: AppTheme.lightTheme(seedColor: initialSeedColor),
      darkTheme: AppTheme.darkTheme(seedColor: initialSeedColor),
      themeMode: ThemeMode.system, // or ThemeMode.light / ThemeMode.dark
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomePage(), // replace with your HomePage
      },
    );
  }
}
