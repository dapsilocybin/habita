import 'package:flutter/material.dart';
import 'package:habita/core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    // Navigate to home after delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient glow behind the circle
            Container(
              width: size.width * 0.78,
              height: size.width * 0.78,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Floating outer circle (levitation)
            Container(
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.30),
                    offset: const Offset(28, 28),
                    blurRadius: 40,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.95),
                    offset: const Offset(-28, -28),
                    blurRadius: 40,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),

            // Inner concave depth using gradient
            Container(
              width: size.width * 0.65,
              height: size.width * 0.65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(0, 0),
                  radius: 0.5,
                  colors: [
                    theme.colorScheme.surface.withOpacity(
                      0.85,
                    ), // darker inside
                    theme.colorScheme.surface.withOpacity(
                      1.0,
                    ), // brighter edges
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),

            // Optional subtle highlight ring for top edge
            Container(
              width: size.width * 0.65,
              height: size.width * 0.65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(-0.2, -0.2),
                  radius: 0.7,
                  colors: [Colors.white.withOpacity(0.15), Colors.transparent],
                ),
              ),
            ),

            // Animated logo, name, slogan
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icons/appIcon.png', // replace with your icon
                      width: size.width * 0.28,
                      height: size.width * 0.28,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Habita",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Build your better self",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
