import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/profile_photo_picker.dart';

class AccountSetupPage extends StatefulWidget {
  final String phoneNumber;

  const AccountSetupPage({super.key, required this.phoneNumber});

  @override
  State<AccountSetupPage> createState() => _AccountSetupPageState();
}

class _AccountSetupPageState extends State<AccountSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _completeSetup() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final username = _usernameController.text.trim();

    // TODO: Create the profile through AuthBloc/API.

    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxHeight < 700;
              final horizontalPadding = constraints.maxWidth < 360
                  ? 16.0
                  : 24.0;
              final verticalPadding = isCompact ? 32.0 : 48.0;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isCompact ? 16 : 24,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: (constraints.maxHeight - verticalPadding)
                        .clamp(0.0, double.infinity)
                        .toDouble(),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: ProfilePhotoPicker(
                                size: isCompact ? 96 : 112,
                              ),
                            ),

                            SizedBox(height: isCompact ? 20 : 28),

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

                            SizedBox(height: isCompact ? 24 : 36),

                            TextFormField(
                              controller: _nameController,
                              textInputAction: TextInputAction.next,
                              textDirection: TextDirection.rtl,
                              decoration: const InputDecoration(
                                labelText: 'نام',
                                hintText: 'نام نمایشی شما',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'نام خود را وارد کن';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            TextFormField(
                              controller: _usernameController,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9_.]'),
                                ),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'نام کاربری',
                                hintText: 'username',
                                prefixIcon: Icon(Icons.alternate_email),
                              ),
                              validator: (value) {
                                final username = value?.trim() ?? '';

                                if (username.isEmpty) {
                                  return 'نام کاربری را وارد کن';
                                }

                                if (username.length < 3) {
                                  return 'نام کاربری باید حداقل ۳ کاراکتر باشد';
                                }

                                return null;
                              },
                              onFieldSubmitted: (_) => _completeSetup(),
                            ),

                            SizedBox(height: isCompact ? 24 : 32),

                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _completeSetup,
                                child: const Text('شروع مسیر'),
                              ),
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
