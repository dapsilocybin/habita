import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Login Icon
                Icon(
                  Icons.lock_open,
                  size: 64,
                  color: colorScheme.primary,
                ),
                SizedBox(height: 20),

                // Login Title
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),

                // Username Input
                TextField(
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Password Input
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 24),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Add login logic
                  },
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 16),

                // Forgotten Password Link
                TextButton(
                  onPressed: () {
                    // Navigate to Forgotten Password Page
                    context.goNamed("forget-password");
                  },
                  child: Text(
                    "Forgotten password?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: colorScheme.secondary,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Sign Up Prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: colorScheme.onBackground.withOpacity(0.8)),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Sign Up Page
                        context.goNamed("sign-up");
                      },
                      child: Text("Sign Up"),
                      style: TextButton.styleFrom(
                        foregroundColor: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
