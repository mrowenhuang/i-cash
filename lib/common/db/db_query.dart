class DbQuery {
  final String userLogin = '''
    CREATE TABLE users_login (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NULL,
      userRole TEXT NULL,
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

  final String table = '''
  CREATE TABLE many_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    manyTable TEXT NULL
  )
  ''';

  final String tax = '''
  CREATE TABLE tax (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nameTax TEXT NULL,
    percentTax TEXT NULL,
    activeTax TEXT NULL
  )
  ''';

  final String orderMenuTable = '''
  CREATE TABLE order_menu (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    orderId TEXT NULL,
    orderDate TEXT NULL,
    employeeName TEXT NULL,
    employeeRole TEXT NULL,
    foodOrder TEXT NULL,
    drinkOrder TEXT NULL,
    serviceAndTax TEXT NULL,
    noTaxPrice TEXT NULL,
    totalPrice TEXT NULL,
    status TEXT NULL,
    sendStatus TEXT NULL,
    createdAt TEXT NULL,
    sendAt TEXT NULL,
    updateAt TEXT NULL    
  )
  ''';
}
