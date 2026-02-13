import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepositories {
  Future<Either<ServerFailure, UserCredential>> loginUser({
    required String email,
    required String password,
  });

  // Future<Either<server>>
}
