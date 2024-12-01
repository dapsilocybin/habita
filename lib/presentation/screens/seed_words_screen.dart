import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SeedWordsScreen extends StatelessWidget {
  final List<String> seedWords = [
    "apple", "banana", "cherry", "date", "elderberry",
    "fig", "grape", "honeydew", "kiwi", "lemon",
    "mango", "nectarine"
  ];

  void copySeedWords() {
    Clipboard.setData(ClipboardData(text: seedWords.join(" ")));
  }

  void navigateToNextPage(BuildContext context) {
    // Navigate to the next page after confirmation
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Page Icon
                Icon(
                  Icons.vpn_key,
                  size: 64,
                  color: colorScheme.primary,
                ),
                SizedBox(height: 16),

                // Page Title
                Text(
                  "Your Seed Words",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),

                // Seed Words Explanation Text
                Text(
                  "Below are your unique seed words. Please write them down or save them securely.",
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onBackground.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),

                // Seed Words List (Grid or Wrap for readability)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: seedWords.map((word) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        word,
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 24),

                // Copy Button
                ElevatedButton.icon(
                  onPressed: copySeedWords,
                  icon: Icon(Icons.copy),
                  label: Text("Copy Seed Words"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    foregroundColor: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 24),

                // Confirmation Button
                ElevatedButton(
                  onPressed: () => navigateToNextPage(context),
                  child: Text("I Wrote Down My Words"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),

            // Warning Container (Overlay)
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
                    Icon(Icons.warning, color: colorScheme.onErrorContainer),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Your seed words are crucial for wallet recovery. "
                        "Store them securely. Without them, access to your wallet cannot be restored.",
                        style: TextStyle(
                          color: colorScheme.onErrorContainer,
                        ),
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
