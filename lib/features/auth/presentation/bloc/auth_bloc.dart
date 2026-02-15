import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_login.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_read_login_data.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLogin _authLogin;
  final AuthReadLoginData _authReadLoginData;

  AuthBloc(this._authLogin, this._authReadLoginData) : super(LoginInitial()) {
    on<LoginClickAuthEvent>(loginClickAuthEvent);
  }

  FutureOr<void> loginClickAuthEvent(
    LoginClickAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthLoginState());

    var response = await _authLogin.execute(event.email, event.password);

    await response.fold(
      (failure) async {
        emit(FailedAuthLoginState(message: failure.message));
      },
      (response) async {
        var response2 = await _authReadLoginData.call(
          uid: response.user!.uid,
          email: event.email,
          password: event.password,
        );

        response2.fold(
          (failure) {
            emit(FailedAuthLoginState(message: failure.message));
          },
          (response) {
            emit(SuccessAuthLoginState(userLogin: response));
          },
        );
      },
    );
  }
}
