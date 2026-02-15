import 'package:i_cash/common/db/local_database.dart';
import 'package:i_cash/features/menu/data/models/menu_model.dart';

abstract class SettingLocalDatasource {
  Future<bool> insertMenuDataToLocal({required List<MenuModel> menuData});
  Future<bool> clearMenuDataFromLocal();
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
}
