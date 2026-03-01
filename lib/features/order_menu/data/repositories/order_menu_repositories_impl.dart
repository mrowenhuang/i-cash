import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/core/entities/order_menu_entities.dart';
import 'package:i_cash/core/model/order_menu_model.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/order_menu/data/datasources/local/order_menu_local_datasource.dart';
import 'package:i_cash/features/order_menu/data/models/order_item_model.dart';
import 'package:i_cash/features/order_menu/domain/entities/order_item_entites.dart';
import 'package:i_cash/features/order_menu/domain/repositories/order_menu_repositories.dart';
import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';

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

  @override
  Future<Either<ServerFailure, String>> addOrderMenuTakeAway({
    required String serviceAndTax,
    required UserLoginEntities userData,
    required String noTaxPrice,
    required String totalPrice,
    required List<OrderItemEntites> cartMakanan,
    required List<OrderItemEntites> cartMinuman,
  }) async {
    // PERBAIKAN: Pastikan menggunakan method yang mengembalikan Map<String, dynamic>
    // Jika toJson() Anda sudah mengembalikan Map, pastikan tidak ada jsonEncode di dalam method tersebut.
    final drinkList = cartMinuman
        .map(
          (e) => OrderItemModel.fromEntity(e).toMap(),
        ) // Gunakan toMap() atau pastikan toJson() mengembalikan Map
        .toList();

    final foodList = cartMakanan
        .map((e) => OrderItemModel.fromEntity(e).toMap())
        .toList();

    OrderMenuModel orderMenuModel = OrderMenuModel(
      createdAt: DateTime.now().toString(),
      drinkOrder: jsonEncode(
        drinkList,
      ), // Sekarang ini akan menjadi [{},{}] bukan ["{}","{}"]
      employeeName: userData.username,
      employeeRole: userData.userRole,
      foodOrder: jsonEncode(foodList),
      noTaxPrice: noTaxPrice,
      orderDate: DateTime.now().toString(),
      orderId: DateTime.now().microsecondsSinceEpoch.toString(),
      status: 'done',
      sendStatus: 'pending',
      serviceAndTax: serviceAndTax,
      totalPrice: totalPrice,
      updateAt: DateTime.now().toString(),
    );

    try {
      final response = await _orderMenuLocalDatasource
          .addOrderMenuModelDataToLocal(orderMenuModel);

      if (response) {
        return right("Data Berhasil ditambahkan");
      } else {
        return left(ServerFailure(message: "Data gagal ditambahkan"));
      }
    } catch (e) {
      return left(ServerFailure(message: "Terjadi kesalahan $e"));
    }
  }
}
