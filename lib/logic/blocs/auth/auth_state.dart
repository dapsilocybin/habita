
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show User;

import 'auth_method.dart';

enum AuthStatus {
  initial,
  loading,
  otpSent,
  authenticated,
  signedOut,
  error,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.identifier,
    this.method,
    this.user,
    this.errorMessage,
  });

  final AuthStatus status;
  final String? identifier;
  final AuthMethod? method;
  final User? user;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    String? identifier,
    AuthMethod? method,
    User? user,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      identifier: identifier ?? this.identifier,
      method: method ?? this.method,
      user: user ?? this.user,
      errorMessage:
          clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        identifier,
        method,
        user,
        errorMessage,
      ];
}
