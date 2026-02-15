import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';

abstract class SettingRemoteDatasource {
  Future<Either<ServerFailure, DataSnapshot>> syncMenu({
    required UserLoginEntities userLoginData,
  });
}

class SettingRemoteDatasourceImpl implements SettingRemoteDatasource {
  final FirebaseDatabase _firebaseDatabase;

  SettingRemoteDatasourceImpl(this._firebaseDatabase);

  @override
  Future<Either<ServerFailure, DataSnapshot>> syncMenu({
    required UserLoginEntities userLoginData,
  }) async {
    try {
      final ref = _firebaseDatabase.ref();
      final String? clean = userLoginData.brand
          ?.replaceAll(RegExp(r'\s+'), '')
          .toLowerCase();

      final snapshot = await ref.child('$clean/menu').get();
      return Right(snapshot);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Get menu data failed'));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred'));
    }
  }
}
