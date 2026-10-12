
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_event.dart';
import '../../../logic/blocs/auth/auth_method.dart';
import '../../../logic/blocs/auth/auth_state.dart';
import 'account_setup_page.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    required this.identifier,
    required this.method,
  });

  final String identifier;
  final AuthMethod method;

  @override
  State<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState
    extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  bool get _isEmail => widget.method == AuthMethod.email;

  void _verifyOtp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
          VerifyOtpRequested(
            identifier: widget.identifier,
            token: _otpController.text.trim(),
            method: widget.method,
          ),
        );
  }

  void _resendOtp() {
    context.read<AuthBloc>().add(
          SendOtpRequested(widget.identifier),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            tooltip: 'بازگشت',
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.status != current.status ||
                previous.errorMessage != current.errorMessage,
            listener: (context, state) {
              if (state.status == AuthStatus.authenticated) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (_) => AccountSetupPage(
                      phoneNumber: widget.identifier,
                    ),
                  ),
                );
              } else if (state.status == AuthStatus.otpSent) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        _isEmail
                            ? 'کد جدید به ایمیل شما ارسال شد.'
                            : 'کد جدید از طریق پیامک ارسال شد.',
                      ),
                    ),
                  );
              } else if (state.status == AuthStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage ??
                            'عملیات ناموفق بود. دوباره تلاش کنید.',
                      ),
                    ),
                  );
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final isLoading =
                    state.status == AuthStatus.loading;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxHeight < 700;
                    final horizontalPadding =
                        constraints.maxWidth > 600 ? 48.0 : 24.0;

                    return SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        isCompact ? 12 : 24,
                        horizontalPadding,
                        28,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight -
                              (isCompact ? 40 : 52),
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 420,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: Container(
                                      width: isCompact ? 84 : 100,
                                      height: isCompact ? 84 : 100,
                                      decoration: BoxDecoration(
                                        color: colors.primaryContainer,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        _isEmail
                                            ? Icons.mark_email_read_outlined
                                            : Icons.sms_outlined,
                                        size: isCompact ? 42 : 50,
                                        color: colors.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  Text(
                                    'تأیید حساب کاربری',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _isEmail
                                        ? 'کد تأیید ارسال‌شده به ایمیل زیر را وارد کنید.'
                                        : 'کد تأیید ارسال‌شده به شماره زیر را وارد کنید.',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: colors.onSurfaceVariant,
                                      height: 1.8,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: SelectableText(
                                      widget.identifier,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: colors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: isCompact ? 28 : 36),
                                  Text(
                                    'کد تأیید ۶ رقمی',
                                    style: theme.textTheme.titleSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _otpController,
                                    keyboardType: TextInputType.number,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.center,
                                    autofocus: true,
                                    autofillHints: const [
                                      AutofillHints.oneTimeCode,
                                    ],
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly,
                                      LengthLimitingTextInputFormatter(6),
                                    ],
                                    validator: (value) {
                                      final token =
                                          value?.trim() ?? '';

                                      if (token.isEmpty) {
                                        return 'کد تأیید را وارد کنید.';
                                      }

                                      if (token.length != 6) {
                                        return 'کد تأیید باید ۶ رقم باشد.';
                                      }

                                      return null;
                                    },
                                    onFieldSubmitted: (_) {
                                      if (!isLoading) _verifyOtp();
                                    },
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                      letterSpacing: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '------',
                                      hintStyle: TextStyle(
                                        color: colors.onSurfaceVariant
                                            .withValues(alpha: 0.5),
                                        letterSpacing: 8,
                                      ),
                                      filled: true,
                                      fillColor: colors.surface,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16),
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
                                      onPressed:
                                          isLoading ? null : _verifyOtp,
                                      style: FilledButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                              width: 22,
                                              height: 22,
                                              child:
                                                  CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text(
                                              'تأیید و ادامه',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextButton(
                                    onPressed:
                                        isLoading ? null : _resendOtp,
                                    child: Text(
                                      _isEmail
                                          ? 'ارسال مجدد کد به ایمیل'
                                          : 'ارسال مجدد کد پیامکی',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton(
                                    onPressed: isLoading
                                        ? null
                                        : () => Navigator.of(context).pop(),
                                    child: const Text(
                                      'تغییر شماره موبایل یا ایمیل',
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
