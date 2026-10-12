import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_event.dart';
import '../../../logic/blocs/auth/auth_state.dart';
import 'otp_verification_page.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  String? _validateIdentifier(String? value) {
    final input = value?.trim() ?? '';

    if (input.isEmpty) {
      return 'شماره موبایل یا ایمیل را وارد کنید.';
    }

    if (input.contains('@')) {
      final validEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(input);

      return validEmail ? null : 'آدرس ایمیل معتبر نیست.';
    }

    final phone = input.replaceAll(RegExp(r'[\s()-]'), '');

    final validPhone = RegExp(
      r'^(?:\+?[1-9]\d{7,14}|00[1-9]\d{6,13})$',
    ).hasMatch(phone);

    if (!validPhone) {
      return 'شماره موبایل معتبر نیست. کد کشور را بررسی کنید.';
    }

    return null;
  }

  void _sendOtp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
      SendOtpRequested(_identifierController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == AuthStatus.otpSent &&
                  state.identifier != null &&
                  state.method != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (_) => OtpVerificationPage(
                      identifier: state.identifier!,
                      method: state.method!,
                    ),
                  ),
                );
              } else if (state.status == AuthStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage ?? 'ارسال کد تأیید ناموفق بود.',
                      ),
                    ),
                  );
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final isLoading = state.status == AuthStatus.loading;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxHeight < 700;
                    final horizontalPadding = constraints.maxWidth > 600
                        ? 48.0
                        : 24.0;

                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: isCompact ? 20 : 36,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight:
                              constraints.maxHeight - (isCompact ? 40 : 72),
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 420),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: Container(
                                      width: isCompact ? 96 : 112,
                                      height: isCompact ? 96 : 112,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: colors.surface,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: colors.shadow.withValues(
                                              alpha: 0.10,
                                            ),
                                            blurRadius: 24,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.spa_rounded,
                                        size: isCompact ? 54 : 64,
                                        color: colors.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'به هابیتا خوش آمدید',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'برای ادامه، شماره موبایل یا ایمیل خود را وارد کنید.',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colors.onSurfaceVariant,
                                      height: 1.8,
                                    ),
                                  ),
                                  SizedBox(height: isCompact ? 28 : 36),
                                  Text(
                                    'شماره موبایل یا ایمیل',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _identifierController,
                                    keyboardType: TextInputType.emailAddress,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    validator: _validateIdentifier,
                                    onFieldSubmitted: (_) {
                                      if (!isLoading) _sendOtp();
                                    },
                                    decoration: InputDecoration(
                                      hintText:
                                          '09126389220 یا name@example.com',
                                      hintTextDirection: TextDirection.ltr,
                                      hintStyle: TextStyle(
                                        color: colors.onSurfaceVariant
                                            .withValues(alpha: 0.65),
                                        fontSize: 13,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.person_outline_rounded,
                                      ),
                                      filled: true,
                                      fillColor: colors.surface,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: colors.outlineVariant,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  SizedBox(
                                    height: 54,
                                    child: FilledButton(
                                      onPressed: isLoading ? null : _sendOtp,
                                      style: FilledButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                              width: 22,
                                              height: 22,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text(
                                              'دریافت کد تأیید',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'با ادامه دادن، کد تأیید از طریق پیامک یا ایمیل برای شما ارسال می‌شود.',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colors.onSurfaceVariant,
                                      height: 1.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
