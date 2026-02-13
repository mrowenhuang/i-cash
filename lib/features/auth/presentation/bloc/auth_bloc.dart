import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  LoginBloc() : super(LoginInitial()) {
    
  }
}
