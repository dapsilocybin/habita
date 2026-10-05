import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePhoneNumberPage extends StatefulWidget {
  const ChangePhoneNumberPage({super.key});

  @override
  State<ChangePhoneNumberPage> createState() => _ChangePhoneNumberPageState();
}

class _ChangePhoneNumberPageState extends State<ChangePhoneNumberPage> {
  final TextEditingController _phoneController =
      TextEditingController(text: '09123456789');

  bool _isSubmitting = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendVerificationCode() async {
    final phoneNumber = _phoneController.text.trim();

    if (phoneNumber.isEmpty) {
      _showMessage('لطفاً شماره موبایل جدید را وارد کنید.');
      return;
    }

    if (phoneNumber.length < 10) {
      _showMessage('شماره موبایل واردشده معتبر نیست.');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // TODO: Call the change-phone API and send OTP.

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PhoneChangeVerificationPage(
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تغییر شماره موبایل'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildCurrentNumberCard(context),
                const SizedBox(height: 24),
                _buildPhoneField(context),
                const SizedBox(height: 20),
                _buildSecurityNotice(context),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: _isSubmitting
                        ? null
                        : _sendVerificationCode,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text('ارسال کد تأیید'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.16),
            blurRadius: 22,
            offset: const Offset(6, 8),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.85),
            blurRadius: 22,
            offset: const Offset(-6, -8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.16),
                  blurRadius: 18,
                  offset: const Offset(5, 7),
                ),
                BoxShadow(
                  color: colorScheme.surface.withOpacity(0.9),
                  blurRadius: 18,
                  offset: const Offset(-5, -7),
                ),
              ],
            ),
            child: Icon(
              Icons.phone_android_outlined,
              size: 36,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'شماره موبایل خود را تغییر دهید',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'برای تغییر شماره، ابتدا شماره جدید را وارد کنید. سپس یک کد تأیید برای آن ارسال می‌شود.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentNumberCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.65),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.verified_user_outlined,
            color: colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'شماره فعلی',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer.withOpacity(0.75),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '۰۹۱۲۳۴۵۶۷۸۹',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'شماره موبایل جدید',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[0-9]'),
            ),
            LengthLimitingTextInputFormatter(15),
          ],
          decoration: InputDecoration(
            hintText: '09123456789',
            prefixIcon: const Icon(
              Icons.phone_outlined,
            ),
            suffixIcon: _phoneController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _phoneController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          onChanged: (_) {
            setState(() {});
          },
        ),
        const SizedBox(height: 8),
        Text(
          'شماره جدید باید به نام خودتان و قابل دسترسی برای دریافت پیامک باشد.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityNotice(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 14,
            offset: const Offset(3, 5),
          ),
          BoxShadow(
            color: colorScheme.surface.withOpacity(0.75),
            blurRadius: 14,
            offset: const Offset(-3, -5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'برای حفظ امنیت حساب، تغییر شماره موبایل فقط پس از تأیید کد ارسال‌شده به شماره جدید انجام می‌شود.',
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneChangeVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const PhoneChangeVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<PhoneChangeVerificationPage> createState() =>
      _PhoneChangeVerificationPageState();
}

class _PhoneChangeVerificationPageState
    extends State<PhoneChangeVerificationPage> {
  final TextEditingController _codeController = TextEditingController();

  bool _isVerifying = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();

    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('کد تأیید باید ۶ رقم باشد.'),
        ),
      );
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    // TODO: Verify OTP and update the user's phone number.

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) {
      return;
    }

    setState(() {
      _isVerifying = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('شماره موبایل با موفقیت تغییر کرد.'),
      ),
    );

    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );
  }

  void _resendCode() {
    // TODO: Request a new OTP.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('کد تأیید مجدداً ارسال شد.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تأیید شماره جدید'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
            child: Column(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surfaceContainerHighest,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withOpacity(0.16),
                        blurRadius: 20,
                        offset: const Offset(5, 7),
                      ),
                      BoxShadow(
                        color: colorScheme.surface.withOpacity(0.85),
                        blurRadius: 20,
                        offset: const Offset(-5, -7),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.sms_outlined,
                    size: 40,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'کد تأیید را وارد کنید',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'کد ۶ رقمی ارسال‌شده به شماره زیر را وارد کنید.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.phoneNumber,
                  textDirection: TextDirection.ltr,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: theme.textTheme.headlineSmall?.copyWith(
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: '••••••',
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _resendCode,
                  child: const Text('ارسال مجدد کد'),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: _isVerifying ? null : _verifyCode,
                    child: _isVerifying
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text('تأیید و تغییر شماره'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}