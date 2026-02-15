import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_login.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_login_offline.dart';
import 'package:i_cash/features/auth/domain/usecases/auth_read_login_data.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLogin _authLogin;
  final AuthReadLoginData _authReadLoginData;
  final AuthLoginOffline _authLoginOffline;

  AuthBloc(this._authLogin, this._authReadLoginData, this._authLoginOffline)
    : super(LoginInitial()) {
    on<LoginClickAuthEvent>(loginClickAuthEvent);
    on<CheckInternetAuthEvent>(checkInternetAuthEvent);
    on<LoginOfflineClickAuthEvent>(loginOfflineClickAuthEvent);
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

  FutureOr<void> checkInternetAuthEvent(
    CheckInternetAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingInternetAuthState());
    
    final bool isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
      emit(HaveInternetAuthState(isConnected: true));
    } else {
      emit(NoInternetAuthState(isConnected: false));
    }
  }

  FutureOr<void> loginOfflineClickAuthEvent(
    LoginOfflineClickAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthLoginState());

    var response = await _authLoginOffline.call(
      email: event.email,
      password: event.password,
    );

    response.fold(
      (l) {
        emit(FailedAuthLoginState(message: l.message));
      },
      (r) {
        emit(SuccessAuthLoginState(userLogin: r));
      },
    );
  }
}
