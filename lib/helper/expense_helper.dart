import 'package:final_exam1/modal/expense_modal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class DBHelper {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }
  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'expenses.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL,
            category TEXT
          )
        ''');
      },
    );
  }


  static Future<int> insertExpense(Expense expense) async {
    final db = await getDatabase();
    return await db.insert('expenses', expense.toMap());
  }


  static Future<List<Expense>> getExpenses() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }
  static Future<int> updateExpense(Expense expense) async {
    final db = await getDatabase();
    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }
  static Future<int> deleteExpense(int id) async {
    final db = await getDatabase();
    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
