import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/auth/domain/repositories/auth_repositories.dart';

class AuthReadLoginData {
  final AuthRepositories _authRepositories;

  AuthReadLoginData(this._authRepositories);

  Future<Either<ServerFailure, UserLoginEntities>> call({
    required String uid,
    required String email,
    required String password,
  }) async {
    return await _authRepositories.readLoginUser(
      uid: uid,
      email: email,
      password: password,
    );
  }
}
