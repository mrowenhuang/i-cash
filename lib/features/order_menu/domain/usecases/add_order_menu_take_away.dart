import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/core/entities/order_menu_entities.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/order_menu/domain/entities/order_item_entites.dart';
import 'package:i_cash/features/order_menu/domain/repositories/order_menu_repositories.dart';

class AddOrderMenuTakeAway {
  final OrderMenuRepositories _orderMenuRepositories;

  AddOrderMenuTakeAway(this._orderMenuRepositories);

  Future<Either<ServerFailure, String>> call({
    required String serviceAndTax,
    required UserLoginEntities userData,
    required String noTaxPrice,
    required String totalPrice,
    required List<OrderItemEntites> cartMakanan,
    required List<OrderItemEntites> cartMinuman,
  }) async {
    return await _orderMenuRepositories.addOrderMenuTakeAway(
      serviceAndTax: serviceAndTax,
      userData: userData,
      noTaxPrice: noTaxPrice,
      totalPrice: totalPrice,
      cartMakanan: cartMakanan,
      cartMinuman: cartMinuman,
    );
  }
}
