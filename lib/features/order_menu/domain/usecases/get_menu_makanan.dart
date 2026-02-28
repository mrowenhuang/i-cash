import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/order_menu/domain/repositories/order_menu_repositories.dart';

class GetMenuMakanan {
  final OrderMenuRepositories _orderMenuRepositories;

  GetMenuMakanan(this._orderMenuRepositories);

  Future<Either<ServerFailure, List<MenuEntities>>> call() async {
    return await _orderMenuRepositories.getMenuMakananData();
  }
}
