import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool showError = false; // Controls error visibility

  void showErrorContainer() {
    setState(() {
      showError = true;
    });
    // Hide the error automatically after a few seconds
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showError = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Instructional Text
                  Text(
                    "Enter your registered email to receive a reset code.",
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onBackground.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Email Input Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      // Add reset logic here
                      // For demonstration, we'll show an error
                      showErrorContainer();
                    },
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Error Container (Overlay)
          if (showError)
            Positioned(
              top: 40.0,
              left: 24.0,
              right: 24.0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: colorScheme.onErrorContainer),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "An error occurred. Please try again.",
                        style: TextStyle(
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: colorScheme.onErrorContainer),
                      onPressed: () {
                        setState(() {
                          showError = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
