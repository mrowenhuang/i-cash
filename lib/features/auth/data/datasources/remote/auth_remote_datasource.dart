import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';

abstract class AuthRemoteDatasource {
  Future<Either<ServerFailure, UserCredential>> loginAuth({
    required String email,
    required String password,
  });
  Future<Either<ServerFailure, DataSnapshot>> readLoginAuthData({
    required String uid,
  });
  Future<Either<ServerFailure, bool>> updateLoginAutDeviceIdData({
    required String uid,
    required String deviceId,
    required UserLogin userLoginData,
  });
  // Future<void> readLoginAuthData({required String uid});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseDatabase _firebaseDatabase;
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDatasourceImpl(this._firebaseDatabase, this._firebaseAuth);

  @override
  Future<Either<ServerFailure, UserCredential>> loginAuth({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Authentication failed'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<ServerFailure, DataSnapshot>> readLoginAuthData({
    required String uid,
  }) async {
    try {
      final ref = _firebaseDatabase.ref();
      final snapshot = await ref.child('users/$uid').get();
      return Right(snapshot);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Get user login failed'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<ServerFailure, bool>> updateLoginAutDeviceIdData({
    required String uid,
    required String deviceId,
    required UserLogin userLoginData,
  }) async {
    try {
      final ref = _firebaseDatabase.ref();
      await ref.child('users/$uid').update(userLoginData.toMap());

      return const Right(true);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Update gagal'));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error'));
    }
  }
}
