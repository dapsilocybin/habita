
import 'package:equatable/equatable.dart';

import 'auth_method.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SendOtpRequested extends AuthEvent {
  const SendOtpRequested(this.identifier);

  final String identifier;

  @override
  List<Object?> get props => [identifier];
}

class VerifyOtpRequested extends AuthEvent {
  const VerifyOtpRequested({
    required this.identifier,
    required this.token,
    required this.method,
  });

  final String identifier;
  final String token;
  final AuthMethod method;

  @override
  List<Object?> get props => [identifier, token, method];
}

class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}
