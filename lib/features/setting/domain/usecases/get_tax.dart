import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';
import 'package:i_cash/features/setting/domain/repositories/setting_repositories.dart';

class GetTax {
  final SettingRepositories _settingRepositories;

  GetTax(this._settingRepositories);

  Future<Either<ServerFailure, List<TaxEntites>>> call() async {
    return await _settingRepositories.getTaxFromLocal();
  }
}
