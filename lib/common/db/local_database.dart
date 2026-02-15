import 'package:i_cash/common/db/db_query.dart';
import 'package:i_cash/features/auth/data/models/user_login.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('icash.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Future<Database> _initDB(String fileName) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final path = join(dir.path, fileName);

  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: _createDB,
  //     onOpen: (db) async {
  //       await _createDB(db, 1); // paksa cek & buat tabel lagi
  //     },
  //   );
  // }

  Future _createDB(Database db, int version) async {
    await db.execute(DbQuery().userLogin);
    await db.execute(DbQuery().menuTable);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
