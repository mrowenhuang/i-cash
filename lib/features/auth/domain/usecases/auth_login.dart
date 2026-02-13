import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/auth/domain/repositories/auth_repositories.dart';

class AuthLogin {
  final AuthRepositories _authRepository;

  AuthLogin(this._authRepository);

  Future<Either<ServerFailure,UserCredential>> execute(String email, String password) async {
    return await _authRepository.loginUser(email: email, password: password);
  }
}
