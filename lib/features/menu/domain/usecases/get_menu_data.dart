import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/menu/domain/repositories/menu_repositories.dart';

class GetMenuData {
  final MenuRepositories _menuRepositories;

  GetMenuData(this._menuRepositories);

  Future<Either<ServerFailure, List<MenuEntities>>> call() async {
    return await _menuRepositories.getMenuData();
  }
}
