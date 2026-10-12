
import 'package:supabase_flutter/supabase_flutter.dart'
    show SupabaseClient, User, OtpType;

enum AuthMethod {
  phone,
  email,
}

class AuthProvider {
  AuthProvider(this._client);

  final SupabaseClient _client;

  Future<void> sendOtp({
    required String identifier,
    required AuthMethod method,
  }) async {
    if (method == AuthMethod.email) {
      await _client.auth.signInWithOtp(
        email: identifier,
      );
    } else {
      await _client.auth.signInWithOtp(
        phone: identifier,
      );
    }
  }

  Future<User> verifyOtp({
    required String identifier,
    required String token,
    required AuthMethod method,
  }) async {
    final response = await _client.auth.verifyOTP(
      email: method == AuthMethod.email ? identifier : null,
      phone: method == AuthMethod.phone ? identifier : null,
      token: token,
      type: method == AuthMethod.email
          ? OtpType.email
          : OtpType.sms,
    );

    final user = response.user;

    if (user == null) {
      throw Exception('تأیید کد انجام نشد.');
    }

    return user;
  }

  Future<void> signOut() => _client.auth.signOut();

  User? get currentUser => _client.auth.currentUser;
}
