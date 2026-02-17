import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';
import 'package:i_cash/features/setting/domain/repositories/setting_repositories.dart';

class AddTax {
  final SettingRepositories _settingRepositories;

  AddTax(this._settingRepositories);

  Future<Either<ServerFailure, String>> call({
    required String taxName,
    required String taxPercent,
  }) async {
    var taxData = TaxEntites(
      activeTax: '1',
      nameTax: taxName,
      percentTax: taxPercent,
    );

    return await _settingRepositories.addTaxToLocal(taxData: taxData);
  }
}
