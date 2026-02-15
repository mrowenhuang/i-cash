import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';

abstract class AuthRepositories {
  Future<Either<ServerFailure, UserCredential>> loginUser({
    required String email,
    required String password,
  });
  Future<Either<ServerFailure, UserLoginEntities>> loginUserOffline({
    required String email,
    required String password,
  });
  Future<Either<ServerFailure, UserLoginEntities>> readLoginUser({
    required String uid,
    required String email,
    required String password,
  });
  // Future<Either<ServerFailure, DataSnapshot>> checkLoginDevice({
  //   required String uid,
  //   required String deviceId,
  //   required UserLogin userLoginData,
  // });

  // Future<Either<server>>
}
