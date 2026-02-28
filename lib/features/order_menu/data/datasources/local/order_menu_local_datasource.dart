import 'package:i_cash/common/db/local_database.dart';
import 'package:i_cash/features/menu/data/models/menu_model.dart';

abstract class OrderMenuLocalDatasource {
  Future<List<MenuModel>?> getMenuMakananDataFromLocal();
  Future<List<MenuModel>?> getMenuMinumanDataFromLocal();
}

class OrderMenuLocalDatasourceImpl implements OrderMenuLocalDatasource {
  final LocalDatabase _localDatabase;

  OrderMenuLocalDatasourceImpl(this._localDatabase);

  @override
  Future<List<MenuModel>?> getMenuMakananDataFromLocal() async {
    try {
      final db = await _localDatabase.database;

      final maps = await db.query(
        'menu',
        where: 'groupName LIKE ?',
        whereArgs: ['%makanan%'],
      );

      if (maps.isEmpty) return null;

      return maps.map((e) => MenuModel.fromMap(e)).toList();
    } catch (e) {
      print("Get menu error: $e");
      return null;
    }
  }

  @override
  Future<List<MenuModel>?> getMenuMinumanDataFromLocal() async {
    try {
      final db = await _localDatabase.database;

      final maps = await db.query(
        'menu',
        where: 'groupName LIKE ?',
        whereArgs: ['%minuman%'],
      );

      if (maps.isEmpty) return null;

      return maps.map((e) => MenuModel.fromMap(e)).toList();
    } catch (e) {
      print("Get menu error: $e");
      return null;
    }
  }
}
