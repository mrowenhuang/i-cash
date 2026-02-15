import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/menu/data/datasources/local/menu_local_datasource.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/menu/domain/repositories/menu_repositories.dart';

class MenuRepositoriesImpl implements MenuRepositories {
  final MenuLocalDatasource _menuLocalDatasource;

  MenuRepositoriesImpl(this._menuLocalDatasource);

  @override
  Future<Either<ServerFailure, List<MenuEntities>>> getMenuData() async {
    try {
      final response = await _menuLocalDatasource.getMenuDataFromLocal();

      if (response != null && response.isNotEmpty) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: "Tidak Ada Data Menu"));
      }
    } catch (e) {
      return Left(ServerFailure(message: "Error : $e"));
    }
  }
}
