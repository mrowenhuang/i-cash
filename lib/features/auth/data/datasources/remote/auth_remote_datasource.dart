import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:i_cash/common/error/failure.dart';

abstract class AuthRemoteDatasource {
  Future<Either<ServerFailure, UserCredential>> loginAuth({
    required String email,
    required String password,
  });
  Future<void> readLoginAuthData();
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
  Future<void> readLoginAuthData() async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;

      print(userId);

      final ref = _firebaseDatabase.ref();
      final snapshot = await ref.child('users/$userId').get();

      if (snapshot.exists) {
        print(snapshot.value);
      } else {
        print('No data available.');
      }
    } catch (e) {
      print(e);
    }
  }
}
