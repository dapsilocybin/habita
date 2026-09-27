import 'package:flutter/material.dart';

class AccountSetupPage extends StatefulWidget {
  final String phoneNumber;

  const AccountSetupPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<AccountSetupPage> createState() => _AccountSetupPageState();
}

class _AccountSetupPageState extends State<AccountSetupPage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _completeSetup() {
    final name = _nameController.text.trim();
    final username = _usernameController.text.trim();

    if (name.isEmpty || username.isEmpty) {
      return;
    }

    // TODO:
    // Create the user's profile using AuthBloc/API.
    //
    // Example later:
    //
    // context.read<AuthBloc>().add(
    //   CompleteAccountSetupRequested(
    //     name: name,
    //     username: username,
    //   ),
    // );

    // Temporary navigation.
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),

              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.18),
                      offset: const Offset(12, 12),
                      blurRadius: 24,
                    ),
                    BoxShadow(
                      color: colorScheme.surfaceContainerHighest
                          .withOpacity(0.8),
                      offset: const Offset(-10, -10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 48,
                  color: colorScheme.primary,
                ),
              ),

              const SizedBox(height: 32),

              Text(
                'حساب خودت را بساز',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'برای شروع مسیرت در هابیتا چند اطلاعات ساده از خودت وارد کن.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.7,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'نام',
                  hintText: 'نام نمایشی شما',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _usernameController,
                textDirection: TextDirection.ltr,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'نام کاربری',
                  hintText: 'username',
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                onSubmitted: (_) => _completeSetup(),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _completeSetup,
                  child: const Text('شروع مسیر'),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
