import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/auth/domain/repositories/auth_repositories.dart';

class AuthLoginOffline {
  final AuthRepositories repositories;

  AuthLoginOffline(this.repositories);

  Future<Either<ServerFailure, UserLoginEntities>> call({
    required String email,
    required String password,
  }) async {
    return await repositories.loginUserOffline(
      email: email,
      password: password,
    );
  }
}
