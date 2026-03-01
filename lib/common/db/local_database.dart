import 'package:i_cash/common/db/db_query.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  static const _dbName = 'icash.db';
  static const _dbVersion =
      2; // ← tinggal naikkan angka kalau ada perubahan schema

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(DbQuery().userLogin);
    await db.execute(DbQuery().menuTable);
    await db.execute(DbQuery().tax);
    await db.execute(DbQuery().table);
    await db.execute(DbQuery().orderMenuTable);
  }

  /// dipanggil otomatis kalau version naik
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print(oldVersion);

    if (oldVersion < 2) {
      /// contoh upgrade versi 1 → 2
      await db.execute(DbQuery().orderMenuTable);
      // await db.execute(DbQuery().tax);
      // await db.execute(DbQuery().table);

      // await db.execute(DbQuery().userLogin);

      // await db.execute(DbQuery().menuTable);
    }

    // if (oldVersion < 3) {
    //   contoh upgrade versi 2 → 3
    //   await db.execute("ALTER TABLE users_login ADD COLUMN phone TEXT");
    // }

    // tambahkan kondisi lain kalau ada versi baru lagi
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
