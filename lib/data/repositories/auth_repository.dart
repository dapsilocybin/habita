
import 'package:supabase_flutter/supabase_flutter.dart'
    show User;

import '../providers/auth_provider.dart';

class AuthRepository {
  AuthRepository(this._provider);

  final AuthProvider _provider;

  AuthMethod detectMethod(String input) {
    return input.trim().contains('@')
        ? AuthMethod.email
        : AuthMethod.phone;
  }

  String normalizeIdentifier(String input) {
    final value = input.trim();

    if (detectMethod(value) == AuthMethod.email) {
      final email = value.toLowerCase();
      final emailPattern =
          RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

      if (!emailPattern.hasMatch(email)) {
        throw const FormatException(
          'آدرس ایمیل معتبر نیست.',
        );
      }

      return email;
    }

    var phone = value.replaceAll(
      RegExp(r'[\s()-]'),
      '',
    );

    if (phone.startsWith('00')) {
      phone = '+${phone.substring(2)}';
    } else if (phone.startsWith('0')) {
      phone = '+98${phone.substring(1)}';
    } else if (phone.startsWith('98')) {
      phone = '+$phone';
    }

    if (!RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(phone)) {
      throw const FormatException(
        'شماره موبایل معتبر نیست.',
      );
    }

    return phone;
  }

  Future<String> sendOtp(String input) async {
    final method = detectMethod(input);
    final identifier = normalizeIdentifier(input);

    await _provider.sendOtp(
      identifier: identifier,
      method: method,
    );

    return identifier;
  }

  Future<User> verifyOtp({
    required String identifier,
    required String token,
    required AuthMethod method,
  }) async {
    final normalizedIdentifier = normalizeIdentifier(identifier);

    if (detectMethod(normalizedIdentifier) != method) {
      throw const FormatException(
        'روش تأیید با اطلاعات واردشده مطابقت ندارد.',
      );
    }

    return _provider.verifyOtp(
      identifier: normalizedIdentifier,
      token: token.trim(),
      method: method,
    );
  }

  Future<void> signOut() => _provider.signOut();

  User? get currentUser => _provider.currentUser;
}
