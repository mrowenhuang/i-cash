import 'package:i_cash/common/db/local_database.dart';
import 'package:i_cash/features/menu/data/models/menu_model.dart';
import 'package:i_cash/features/setting/data/models/tax_model.dart';

abstract class SettingLocalDatasource {
  Future<bool> insertMenuDataToLocal({required List<MenuModel> menuData});
  Future<bool> clearMenuDataFromLocal();
  Future<bool> insertTaxDataToLocal({required TaxModel taxData});
  Future<List<TaxModel>?> getTaxDataFromLocal();
}

class SettingLocalDatasourceImpl implements SettingLocalDatasource {
  final LocalDatabase _localDatabase;

  SettingLocalDatasourceImpl(this._localDatabase);

  @override
  Future<bool> insertMenuDataToLocal({
    required List<MenuModel> menuData,
  }) async {
    try {
      final db = await _localDatabase.database;

      final batch = db.batch();

      for (var menu in menuData) {
        batch.insert('menu', menu.toMap());
      }

      await batch.commit(noResult: true);

      return true;
    } catch (e) {
      print("Insert menu error: $e");
      return false;
    }
  }

  @override
  Future<bool> clearMenuDataFromLocal() async {
    try {
      final db = await _localDatabase.database;

      final batch = db.batch();
      batch.delete('menu');

      await batch.commit(noResult: true);

      return true;
    } catch (e) {
      print("Clear menu error: $e");
      return false;
    }
  }

  @override
  Future<bool> insertTaxDataToLocal({required TaxModel taxData}) async {
    try {
      final db = await _localDatabase.database;

      await db.insert('tax', taxData.toMap());

      return true;
    } catch (e) {
      print("tax data error: $e");
      return false;
    }
  }

  @override
  Future<List<TaxModel>?> getTaxDataFromLocal() async {
    try {
      final db = await _localDatabase.database;

      final maps = await db.query('tax');

      if (maps.isEmpty) return null;

      return maps.map((e) => TaxModel.fromMap(e)).toList();
    } catch (e) {
      print("get tax error: $e");
      return null;
    }
  }
}
