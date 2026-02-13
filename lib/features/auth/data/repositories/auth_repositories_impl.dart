import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:i_cash/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepositoriesImpl(this._authRemoteDatasource);

  @override
  Future<Either<ServerFailure, UserCredential>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      var response = await _authRemoteDatasource.loginAuth(
        email: email,
        password: password,
      );

      return response;
    } on FirebaseAuthException catch (e) {
      return Left(
        ServerFailure(message: e.message ?? 'An unknown error occurred'),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
