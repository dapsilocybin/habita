
import '../providers/email_password_auth_provider.dart';

class EmailPasswordAuthRepository {
  EmailPasswordAuthRepository(this._provider);

  final EmailPasswordAuthProvider _provider;

  String normalizeEmail(String input) {
    final email = input.trim().toLowerCase();

    final validEmail = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email);

    if (!validEmail) {
      throw const FormatException(
        'آدرس ایمیل معتبر نیست.',
      );
    }

    return email;
  }

  void validatePassword(String password) {
    if (password.length < 8) {
      throw const FormatException(
        'رمز عبور باید حداقل ۸ کاراکتر باشد.',
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = normalizeEmail(email);

    if (password.isEmpty) {
      throw const FormatException(
        'رمز عبور را وارد کنید.',
      );
    }

    await _provider.signIn(
      email: normalizedEmail,
      password: password,
    );
  }

  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = normalizeEmail(email);
    validatePassword(password);

    final response = await _provider.signUp(
      email: normalizedEmail,
      password: password,
    );

    // Supabase returns a session immediately when email
    // confirmation is disabled. Otherwise, confirmation
    // is required before the user can sign in.
    return response.session != null;
  }
}
