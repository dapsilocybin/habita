
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthException;

import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthState()) {
    on<SendOtpRequested>(_onSendOtpRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  final AuthRepository _repository;

  
Future<void> _onSendOtpRequested(
  SendOtpRequested event,
  Emitter<AuthState> emit,
) async {
  emit(state.copyWith(
    status: AuthStatus.loading,
    clearError: true,
  ));

  try {
    final method = _repository.detectMethod(event.identifier);
    final identifier = await _repository.sendOtp(event.identifier);

    emit(state.copyWith(
      status: AuthStatus.otpSent,
      identifier: identifier,
      method: method,
      clearError: true,
    ));
  } on FormatException catch (error) {
    emit(state.copyWith(
      status: AuthStatus.error,
      errorMessage: error.message.toString(),
    ));
  } on AuthException catch (error) {
    emit(state.copyWith(
      status: AuthStatus.error,
      errorMessage: error.message,
    ));
  } catch (_) {
    emit(state.copyWith(
      status: AuthStatus.error,
      errorMessage: 'ارسال کد تأیید ناموفق بود. دوباره تلاش کنید.',
    ));
  }
}

  
Future<void> _onVerifyOtpRequested(
  VerifyOtpRequested event,
  Emitter<AuthState> emit,
) async {
  emit(state.copyWith(
    status: AuthStatus.loading,
    clearError: true,
  ));

  try {
    final user = await _repository.verifyOtp(
      identifier: event.identifier,
      token: event.token,
      method: event.method,
    );

    emit(state.copyWith(
      status: AuthStatus.authenticated,
      user: user,
      clearError: true,
    ));
  } on FormatException catch (error) {
    emit(state.copyWith(
      status: AuthStatus.error,
      errorMessage: error.message.toString(),
    ));
  } on AuthException catch (error) {
    emit(state.copyWith(
      status: AuthStatus.error,
      errorMessage: error.message,
    ));
  } catch (_) {
    emit(state.copyWith(
      status: AuthStatus.error,
      errorMessage: 'تأیید کد ناموفق بود. دوباره تلاش کنید.',
    ));
  }
}

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        clearError: true,
      ),
    );

    try {
      await _repository.signOut();

      emit(
        const AuthState(
          status: AuthStatus.signedOut,
        ),
      );
    } on AuthException catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'خروج از حساب ناموفق بود.',
        ),
      );
    }
  }
}
