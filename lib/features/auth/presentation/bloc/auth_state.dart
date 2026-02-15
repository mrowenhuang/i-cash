part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends AuthState {}

final class LoadingAuthLoginState extends AuthState {}

final class SuccessAuthLoginState extends AuthState {
  final UserLogin userLogin;

  const SuccessAuthLoginState({required this.userLogin});
}

final class FailedAuthLoginState extends AuthState {
  final String message;

  const FailedAuthLoginState({required this.message});
}
