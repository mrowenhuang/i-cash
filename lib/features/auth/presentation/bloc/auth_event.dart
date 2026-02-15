part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class LoginClickAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginClickAuthEvent({required this.email, required this.password});
}



