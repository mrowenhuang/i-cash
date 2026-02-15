import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';

abstract class MenuRepositories {
  Future<Either<ServerFailure, List<MenuEntities>>> getMenuData();
}
