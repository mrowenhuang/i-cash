class DbQuery {
  final String userLogin = '''
    CREATE TABLE users_login (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NULL,
      password TEXT NULL,
      email TEXT NULL,
      brand TEXT NULL,
      address TEXT NULL,
      activeAccount TEXT NULL,
      status TEXT NULL,
      idPerangkat TEXT NULL,
      createdAt TEXT NULL,
      startDate TEXT NULL
    )
  ''';

  final String menuTable = '''
  CREATE TABLE menu (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    idMenu TEXT NULL,
    name TEXT NULL,
    sellPrice TEXT NULL,
    capitalPrice TEXT NULL,
    uomPrice TEXT NULL,
    status TEXT NULL,
    groupName TEXT NULL,
    image TEXT NULL,
    createdAt TEXT NULL,
    updatedAt TEXT NULL
  )
  ''';
}
