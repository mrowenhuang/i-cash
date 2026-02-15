import 'package:i_cash/common/db/local_database.dart';
import 'package:i_cash/features/menu/data/models/menu_model.dart';

abstract class MenuLocalDatasource {
  Future<List<MenuModel>?> getMenuDataFromLocal();
}

class MenuLocalDatasourceImpl implements MenuLocalDatasource {
  final LocalDatabase _localDatabase;

  MenuLocalDatasourceImpl(this._localDatabase);

  @override
  Future<List<MenuModel>?> getMenuDataFromLocal() async {
    try {
      final db = await _localDatabase.database;

      final maps = await db.query('menu');

      if (maps.isEmpty) return null;

      return maps.map((e) => MenuModel.fromMap(e)).toList();
    } catch (e) {
      print("Get menu error: $e");
      return null;
    }
  }
}
