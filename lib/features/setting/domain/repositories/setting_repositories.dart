import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';

abstract class SettingRepositories {
  Future<Either<ServerFailure, String>> syncMenuData({
    required UserLoginEntities userLoginData,
  });
  Future<Either<ServerFailure, String>> addTaxToLocal({
    required TaxEntites taxData,
  });
  Future<Either<ServerFailure, List<TaxEntites>>> getTaxFromLocal();
  Future<Either<ServerFailure, String>> addTableToLocal({
    required String numberOfTable
  });
}
