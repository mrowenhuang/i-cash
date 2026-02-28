import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/setting/domain/repositories/setting_repositories.dart';

class DeleteTax {
  final SettingRepositories _settingRepositories;

  DeleteTax(this._settingRepositories);

  Future<Either<ServerFailure, String>> call({required String key}) async {
    return await _settingRepositories.deleteTaxFromLocal(key: key);
  }
}
