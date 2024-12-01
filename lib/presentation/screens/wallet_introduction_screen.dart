import 'package:flutter/material.dart';

class WalletIntroductionScreen extends StatelessWidget {
  void navigateToSeedWordsPage(BuildContext context) {
    // Navigate to the next page to show seed words
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeedWordsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Page Icon
              Icon(
                Icons.account_balance_wallet,
                size: 64,
                color: colorScheme.primary,
              ),
              SizedBox(height: 16),

              // Page Title
              Text(
                "Wallet Introduction",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

              // Full Description of Wallet and HBT Token
              Text(
                "Welcome to your HBT Wallet! This crypto wallet stores your HBT tokens, "
                "which can be used for in-app transactions, rewards, and more. With this "
                "wallet, you can manage your HBT tokens securely and track your balance. "
                "Please remember that your wallet is unique to you and secure.",
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onBackground.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

              // Important Warning Section
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Important Warning",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your seed words are essential for recovering your wallet. Please write "
                      "them down and store them in a secure place. If you lose these words, "
                      "you will not be able to access your wallet. This is the only way to "
                      "recover your wallet.",
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Show My Words Button
              ElevatedButton(
                onPressed: () => navigateToSeedWordsPage(context),
                child: Text("Show My Words"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder for Seed Words Page
class SeedWordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seed Words"),
      ),
      body: Center(child: Text("Seed words will be shown here.")),
    );
  }
}
