import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:my_cash_book/models/user.dart';
import 'package:my_cash_book/models/cashbook.dart';
import 'package:my_cash_book/constant/finance_type_constants.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;
  DbHelper._createObject();

  factory DbHelper() {
    _dbHelper ??= DbHelper._createObject();
    return _dbHelper!;
  }

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}mycashbook.db';

    var itemDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    return itemDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    password TEXT
  )''');

    await db.execute('''
    CREATE TABLE cashbook (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT,
    amount TEXT,
    description TEXT,
    type TEXT
  )''');

    await db.insert("user", {'username': 'user', 'password': 'user'});
  }

  Future<int> insertUser(User object) async {
    Database db = await database;
    int count = await db.insert('user', object.toMap());
    return count;
  }

  Future<bool> login(String username, String password) async {
    Database db = await database;

    List<Map<String, dynamic>> result = await db.query('user',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> changePassword(String username, String password) async {
    Database db = await database;

    int result = await db.rawUpdate(
        'UPDATE user SET password = ? WHERE username = ?',
        [password, username]);
    return result;
  }

  // Future<List<User>> getUserLogin(String username) async {
  //   Database db = await database;
  //   List<Map<String, dynamic>> result =
  //       await db.query('user', where: 'username = ?', whereArgs: [username]);

  //   List<User> users = [];
  //   for (var i = 0; i < result.length; i++) {
  //     users.add(User.fromMap(result[i]));
  //   }
  //   return users;
  // }

  Future<User?> getUserByUsername(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query('user', where: 'username = ?', whereArgs: [username]);

    if (result.isNotEmpty) {
      return User.fromMap(result[0]);
    } else {
      return null;
    }
  }

  Future<int> insertCashBook(CashBook object) async {
    Database db = await database;
    int count = await db.insert('cashbook', object.toMap());
    return count;
  }

  Future<int> insertIncome(
      String date, String amount, String description) async {
    Database db = await database;

    CashBook incomeData = CashBook(date, amount, description, incomeType);
    //print(incomeData.toMap());
    int count = await db.insert('cashbook', incomeData.toMap());
    return count;
  }

  Future<int> insertExpense(
      String date, String amount, String description) async {
    Database db = await database;

    CashBook expenseData = CashBook(date, amount, description, expenseType);
    int count = await db.insert('cashbook', expenseData.toMap());
    return count;
  }

// get total from income
  Future<int> getTotalIncome() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT SUM(amount) as total FROM cashbook where type = "income"');

    if (result.isNotEmpty && result[0]['total'] != null) {
      int total = result[0]['total'];
      return total;
    } else {
      return 0;
    }
  }

  Future<int> getTotalExpense() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM cashbook where type = "expense"',
    );

    if (result.isNotEmpty && result[0]['total'] != null) {
      int total = result[0]['total'];
      return total;
    } else {
      return 0;
    }
  }

  Future<List<CashBook>> getCashBook() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('cashbook');

    List<CashBook> cashbook = [];
    for (var i = 0; i < result.length; i++) {
      cashbook.add(CashBook.fromMap(result[i]));
    }
    return cashbook;
  }

  // Future<int> insertDataCashBook(CashBook object) async {
  //   Database db = await database;
  //   int count = await db.insert('cashbook', object.toMap());
  //   return count;
  // }

  Future<int> deleteDataCashBook(int id) async {
    Database db = await database;
    int count = await db.delete('cashbook', where: 'id=?', whereArgs: [id]);
    return count;
  }
}
