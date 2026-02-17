import 'package:dartz/dartz.dart';
import 'package:i_cash/common/error/failure.dart';
import 'package:i_cash/core/intern/account_and_token.dart';
import 'package:i_cash/features/auth/domain/entities/user_login_entities.dart';
import 'package:i_cash/features/setting/data/datasources/local/setting_local_datasource.dart';
import 'package:i_cash/features/setting/data/datasources/remote/setting_remote_datasource.dart';
import 'package:i_cash/features/menu/data/models/menu_model.dart';
import 'package:i_cash/features/menu/domain/entities/menu_entities.dart';
import 'package:i_cash/features/setting/data/models/tax_model.dart';
import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';
import 'package:i_cash/features/setting/domain/repositories/setting_repositories.dart';

class SettingReposiotriesImpl implements SettingRepositories {
  final SettingRemoteDatasource _settingRemoteDatasource;
  final SettingLocalDatasource _settingLocalDatasource;

  SettingReposiotriesImpl(
    this._settingRemoteDatasource,
    this._settingLocalDatasource,
  );

  @override
  Future<Either<ServerFailure, String>> syncMenuData({
    required UserLoginEntities userLoginData,
  }) async {
    try {
      final isValid = AccountAndToken().isStillValid(
        userLoginData.startDate.toString(),
        int.parse(userLoginData.activeAccount.toString()),
      );

      if (!isValid) {
        return left(
          ServerFailure(
            message: "Masa Aktif Akun Habis, Silakan Perpanjang Akun",
          ),
        );
      }

      final response = await _settingRemoteDatasource.syncMenu(
        userLoginData: userLoginData,
      );

      return await response.fold(
        (l) async {
          return left(l);
        },
        (r) async {
          if (r.value == null) {
            return left(ServerFailure(message: "Menu kosong"));
          }

          final rawList = List.from(r.value as List);

          final menus = rawList
              .map(
                (e) => MenuModel.fromMap(Map<String, dynamic>.from(e as Map)),
              )
              .toList();

          final cleared = await _settingLocalDatasource
              .clearMenuDataFromLocal();

          if (!cleared) {
            return left(ServerFailure(message: "Gagal hapus menu lokal"));
          }

          final inserted = await _settingLocalDatasource.insertMenuDataToLocal(
            menuData: menus,
          );

          if (!inserted) {
            return left(ServerFailure(message: "Gagal simpan menu lokal"));
          }

          return right("Berhasil Sinkronisasi Menu / ${DateTime.now()}");
        },
      );
    } catch (e) {
      return left(
        ServerFailure(message: "Error saat sinkronisasi menu: ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<ServerFailure, String>> addTaxToLocal({
    required TaxEntites taxData,
  }) async {
    try {
      final response = await _settingLocalDatasource.insertTaxDataToLocal(
        taxData: TaxModel.fromEntity(taxData),
      );

      if (response) {
        return right("Data Berhasil ditambahkan");
      } else {
        return left(ServerFailure(message: "Data gagal ditambahkan"));
      }
    } catch (e) {
      return left(ServerFailure(message: "Terjadi kesalahan $e"));
    }
  }

  @override
  Future<Either<ServerFailure, List<TaxEntites>>> getTaxFromLocal() async {
    try {
      final response = await _settingLocalDatasource.getTaxDataFromLocal();

      if (response != null) {
        return right(response);
      } else {
        return left(ServerFailure(message: "Tidak ada data"));
      }
    } catch (e) {
      return left(ServerFailure(message: "Terjadi kesalahan $e"));
    }
  }

  @override
  Future<Either<ServerFailure, String>> addTableToLocal({
    required String numberOfTable,
  }) async {
    try {
      final response = await _settingLocalDatasource
          .insertNumberOfTableDataToLocal(numberOfTable: numberOfTable);

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
