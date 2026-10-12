import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthException, Supabase;

import '../../../data/providers/email_password_auth_provider.dart';
import '../../../data/repositories/email_password_auth_repository.dart';

class EmailPasswordPage extends StatefulWidget {
  const EmailPasswordPage({super.key, required this.email});

  final String email;

  @override
  State<EmailPasswordPage> createState() => _EmailPasswordPageState();
}

class _EmailPasswordPageState extends State<EmailPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late final EmailPasswordAuthRepository _repository;

  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  void initState() {
    super.initState();

    _repository = EmailPasswordAuthRepository(
      EmailPasswordAuthProvider(Supabase.instance.client),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'رمز عبور را وارد کنید.';
    }

    if (!_isLogin && password.length < 8) {
      return 'رمز عبور باید حداقل ۸ کاراکتر باشد.';
    }

    return null;
  }

  String? _validateConfirmation(String? value) {
    if (!_isLogin && value != _passwordController.text) {
      return 'تکرار رمز عبور مطابقت ندارد.';
    }

    return null;
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    if (_isLoading || !_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });
    debugPrint('Email: ${widget.email}');
    debugPrint('Password: ${_passwordController.text}');
    try {
      if (_isLogin) {
        await _repository.signIn(
          email: widget.email,
          password: _passwordController.text,
        );
      } else {
        final hasSession = await _repository.signUp(
          email: widget.email,
          password: _passwordController.text,
        );

        if (!mounted) return;

        if (!hasSession) {
          _showMessage(
            'حساب ثبت شد، اما ورود خودکار انجام نشد. '
            'تنظیمات تأیید ایمیل Supabase را بررسی کنید.',
          );
          return;
        }
      }

      if (!mounted) return;

      // Supabase has established a session.
      // AuthGate at the root will now display Home.
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FormatException catch (error) {
      _showMessage(error.message.toString());
    } on AuthException catch (error) {
      _showMessage(error.message);
    } catch (_) {
      _showMessage(
        _isLogin
            ? 'ورود ناموفق بود. ایمیل و رمز عبور را بررسی کنید.'
            : 'ساخت حساب ناموفق بود. دوباره تلاش کنید.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
      _passwordController.clear();
      _confirmPasswordController.clear();
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isLogin ? 'ورود به حساب' : 'ساخت حساب کاربری'),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 48,
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
                            Icon(
                              _isLogin
                                  ? Icons.lock_open_rounded
                                  : Icons.person_add_alt_1_rounded,
                              size: 72,
                              color: colors.primary,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              _isLogin ? 'خوش برگشتی!' : 'به هابیتا بپیوند',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.email,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colors.primary,
                              ),
                            ),
                            const SizedBox(height: 28),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              validator: _validatePassword,
                              onFieldSubmitted: (_) {
                                if (_isLogin) _submit();
                              },
                              decoration: InputDecoration(
                                labelText: 'رمز عبور',
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            if (!_isLogin) ...[
                              const SizedBox(height: 18),
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirmation,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                validator: _validateConfirmation,
                                decoration: InputDecoration(
                                  labelText: 'تکرار رمز عبور',
                                  prefixIcon: const Icon(
                                    Icons.lock_reset_rounded,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirmation =
                                            !_obscureConfirmation;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureConfirmation
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'رمز عبور باید حداقل ۸ کاراکتر باشد.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ],
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 54,
                              child: FilledButton(
                                onPressed: _isLoading ? null : _submit,
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        _isLogin ? 'ورود' : 'ساخت حساب و ورود',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: _isLoading ? null : _toggleMode,
                              child: Text(
                                _isLogin
                                    ? 'حساب ندارید؟ ساخت حساب کاربری'
                                    : 'قبلاً حساب ساخته‌اید؟ ورود',
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
          ),
        ),
      ),
    );
  }
}
