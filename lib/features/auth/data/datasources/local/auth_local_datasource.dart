import 'package:i_cash/common/db/local_database.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';

abstract class AuthLocalDatasource {
  Future<void> insertUserLogin({required UserLogin userlogin});
  Future<UserLogin?> getUserLogin({required String email});
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final LocalDatabase _localDatabase;

  AuthLocalDatasourceImpl(this._localDatabase);

  @override
  Future<void> insertUserLogin({required UserLogin userlogin}) async {
    _localDatabase.database.then((db) async {
      await db.insert('users_login', userlogin.toMap());
    });
  }
  
  @override
  Future<UserLogin?> getUserLogin({required String email}) {
    return _localDatabase.database.then((db) async {
      final response = await db.query(
        'users_login',
        where: 'email = ?',
        whereArgs: [email],
      );

      if (response.isNotEmpty) {
        return UserLogin.fromMap(response.first);
      } else {
        return null;
      }
    });
  }
}
