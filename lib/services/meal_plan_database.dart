import 'package:myapp/model/meal_plan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MealPlanDatabase {
  static final MealPlanDatabase instance = MealPlanDatabase._init();
  static Database? _database;

  MealPlanDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('meal_plan.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE meal_plans (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mealType TEXT,
        title TEXT,
        imagePath TEXT,
        servings INTEGER,
        date TEXT
      )
    ''');
  }

  Future<int> insertMeal(MealPlan meal) async {
    final db = await instance.database;
    return await db.insert('meal_plans', meal.toMap());
  }

  Future<List<MealPlan>> fetchMealsByDate(DateTime date) async {
    final db = await instance.database;
    final result = await db.query(
      'meal_plans',
      where: 'date = ?',
      whereArgs: [date.toIso8601String()],
    );
    return result.map((map) => MealPlan.fromMap(map)).toList();
  }

  Future<int> updateMeal(MealPlan meal) async {
    final db = await instance.database;
    return await db.update(
      'meal_plans',
      meal.toMap(),
      where: 'id = ?',
      whereArgs: [meal.id],
    );
  }

  Future<int> deleteMeal(int id) async {
    final db = await instance.database;
    return await db.delete('meal_plans', where: 'id = ?', whereArgs: [id]);
  }
}