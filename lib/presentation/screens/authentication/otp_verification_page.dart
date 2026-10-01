import 'package:flutter/material.dart';

import 'account_setup_page.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpController = TextEditingController();

  bool _isVerifying = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    if (_otpController.text.trim().length != 6) {
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    // Mock authentication.
    //
    // Later this becomes:
    // context.read<AuthBloc>().add(
    //   VerifyOtpRequested(
    //     phoneNumber: widget.phoneNumber,
    //     otp: _otpController.text.trim(),
    //   ),
    // );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _isVerifying = false;
      });

      // Temporary:
      // Treat this as a NEW USER.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => AccountSetupPage(
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    });
  }

  void _resendOtp() {
    // TODO:
    // Send a new OTP using AuthBloc/API.
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 600,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
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
                    Icons.sms_outlined,
                    size: 44,
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'کد تایید را وارد کن',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'کد ۶ رقمی ارسال شده به شماره زیر را وارد کن.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.7,
                  ),
                ),

                const SizedBox(height: 8),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    widget.phoneNumber,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'کد تایید',
                    counterText: '',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  onSubmitted: (_) => _verifyOtp(),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isVerifying ? null : _verifyOtp,
                    child: _isVerifying
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('تایید و ادامه'),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: _resendOtp,
                  child: const Text('ارسال مجدد کد'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
