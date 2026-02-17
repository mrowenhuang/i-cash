import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/setting/domain/repositories/setting_repositories.dart';

class AddTable {
  final SettingRepositories _settingRepositories;

  AddTable(this._settingRepositories);

  Future<Either<ServerFailure, String>> call({
    required String numberOfTable,
  }) async {
    return await _settingRepositories.addTableToLocal(
      numberOfTable: numberOfTable,
    );
  }
}
