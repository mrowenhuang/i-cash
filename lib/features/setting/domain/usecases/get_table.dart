import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/setting/domain/repositories/setting_repositories.dart';

class GetTable {
  final SettingRepositories settingRepositories;

  GetTable(this.settingRepositories);

  Future<Either<ServerFailure, String>> call() async {
    return await settingRepositories.getTableFromLocal();
  }
}
