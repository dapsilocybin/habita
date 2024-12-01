import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Future.delayed(
      Duration(seconds: 3),
    ).then(
      (value) {
        context.goNamed("forget-password");
      },
    );

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // App Logo
            Image.asset(
              'assets/images/logo.png', // Replace with your logo asset path
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),

            // App Name
            Text(
              "Habita",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(height: 10),

            // App Slogan
            Text(
              "Let's grow together :)",
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 40),

            // Loading Indicator
            CircularProgressIndicator(
              color: colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
