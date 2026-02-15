import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/setting/domain/repositories/setting_repositories.dart';

class SyncMenu {
  final SettingRepositories _settingRepositories;

  SyncMenu(this._settingRepositories);


  Future<Either<ServerFailure, String>> call ({required UserLoginEntities userLoginData}) async {
    return await _settingRepositories.syncMenuData(userLoginData: userLoginData);
  }


}
