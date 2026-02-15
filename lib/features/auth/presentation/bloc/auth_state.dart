part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends AuthState {}

final class LoadingAuthLoginState extends AuthState {}

final class SuccessAuthLoginState extends AuthState {
  final UserLoginEntities userLogin;

  const SuccessAuthLoginState({required this.userLogin});
}

final class FailedAuthLoginState extends AuthState {
  final String message;

  const FailedAuthLoginState({required this.message});
}

final class LoadingInternetAuthState extends AuthState {}

final class HaveInternetAuthState extends AuthState {
  final bool isConnected;

  const HaveInternetAuthState({required this.isConnected});
}

final class NoInternetAuthState extends AuthState {
  final bool isConnected;

  const NoInternetAuthState({required this.isConnected});
}
