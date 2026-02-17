import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/core/intern/check_device.dart';
import 'package:i_cash/core/intern/password.dart';
import 'package:i_cash/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:i_cash/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:i_cash/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final AuthRemoteDatasource _authRemoteDatasource;
  final AuthLocalDatasource _authLocalDatasource;

  AuthRepositoriesImpl(this._authRemoteDatasource, this._authLocalDatasource);

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

      print(response);

      return response;
    } on FirebaseAuthException catch (e) {
      return Left(
        ServerFailure(message: e.message ?? 'An unknown error occurred'),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, UserLogin>> readLoginUser({
    required String uid,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authRemoteDatasource.readLoginAuthData(uid: uid);

      return await response.fold((l) async => left(l), (r) async {
        if (r.value == null) {
          return left(ServerFailure(message: "User tidak ada"));
        }

        final data = UserLogin.fromMap(
          Map<String, dynamic>.from(r.value as Map),
        );

        /// VALIDASI EMAIL
        if (data.email != email) {
          return left(ServerFailure(message: "Email / Password Salah"));
        }

        /// VALIDASI PASSWORD
        if (hashPassword(password) != data.password) {
          return left(ServerFailure(message: "Email / Password Salah"));
        }

        /// DEVICE CHECK
        final deviceId = await getDeviceId();

        /// device belum terdaftar → simpan
        if (data.idPerangkat == null || data.idPerangkat!.isEmpty) {
          await _authRemoteDatasource.updateLoginAutDeviceIdData(
            uid: uid,
            deviceId: deviceId,
            userLoginData: data.copyWith(idPerangkat: deviceId),
          );

          return right(data);
        }

        /// device beda
        if (data.idPerangkat != deviceId) {
          return left(ServerFailure(message: "Perangkat Tidak Terdaftar"));
        }

        final response = await _authLocalDatasource.getUserLogin(email: email);

        if (response == null) {
          _authLocalDatasource.insertUserLogin(userlogin: data);
        }

        /// sukses login
        return right(data);
      });
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Database online error'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, UserLogin>> loginUserOffline({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authLocalDatasource.getUserLogin(email: email);

      if (response?.email?.trim().toLowerCase() == email &&
          response?.password == hashPassword(password)) {
        print("Login Offline Berhasil");
        return right(response!);
      } else {
        return left(ServerFailure(message: "Email / Password Salah"));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<ServerFailure, DataSnapshot>> checkLoginDevice({
  //   required String uid,
  //   required String deviceId,
  //   required UserLogin userLoginData,
  // }) {
  //   // TODO: implement checkLoginDevice

  // }

  // @override
  // Future<Either<ServerFailure, DataSnapshot>> checkLoginDevice({
  //   required String uid,
  //   required String deviceId,
  // }) {
  //   try
  // }
}
