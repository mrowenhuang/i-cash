import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/order_menu/data/datasources/local/order_menu_local_datasource.dart';
import 'package:i_cash/features/order_menu/domain/repositories/order_menu_repositories.dart';

class OrderMenuRepositoriesImpl implements OrderMenuRepositories {
  final OrderMenuLocalDatasource _orderMenuLocalDatasource;

  OrderMenuRepositoriesImpl(this._orderMenuLocalDatasource);

  @override
  Future<Either<ServerFailure, List<MenuEntities>>> getMenuMakananData() async {
    try {
      final response = await _orderMenuLocalDatasource
          .getMenuMakananDataFromLocal();

      if (response != null && response.isNotEmpty) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: "Tidak Ada Data Menu Makanan"));
      }
    } catch (e) {
      return Left(ServerFailure(message: "Error : $e"));
    }
  }

  @override
  Future<Either<ServerFailure, List<MenuEntities>>> getMenuMinumanData() async {
    try {
      final response = await _orderMenuLocalDatasource
          .getMenuMinumanDataFromLocal();

      if (response != null && response.isNotEmpty) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: "Tidak Ada Data Menu Makanan"));
      }
    } catch (e) {
      return Left(ServerFailure(message: "Error : $e"));
    }
  }
}
