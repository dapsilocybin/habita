import 'package:flutter/material.dart';

class ResetCodeScreen extends StatefulWidget {
  @override
  _ResetCodeScreenState createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends State<ResetCodeScreen> {
  bool showError = false; // Controls error visibility
  final List<TextEditingController> controllers = List.generate(5, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());

  void showErrorContainer() {
    setState(() {
      showError = true;
    });
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showError = false;
        });
      }
    });
  }

  void submitCode() {
    String code = controllers.map((controller) => controller.text).join();
    if (code.length == 5) {
      // Add submit logic here
    } else {
      showErrorContainer();
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    controllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
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
                    "Enter the 5-digit code sent to your email.",
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onBackground.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Digit Input Fields (Row of 5 TextFields)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: SizedBox(
                          width: 50,
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              counterText: "", // Remove length counter
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: colorScheme.primaryContainer,
                            ),
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                              fontSize: 24,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 4) {
                                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 24),

                  // Submit Button
                  ElevatedButton(
                    onPressed: submitCode,
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
                        "Please enter a valid 5-digit code.",
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
