import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quiz.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE questions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      question TEXT,
      option1 TEXT,
      option2 TEXT,
      option3 TEXT,
      option4 TEXT,
      answer TEXT,
      timeLimit INTEGER  -- New column for custom time
    )
  ''');
  }

  Future<int> insertQuestion(Map<String, dynamic> question) async {
    final db = await instance.database;
    return await db.insert('questions', question);
  }

  Future<int> updateQuestion(int id, Map<String, dynamic> updatedQuestion) async {
    final db = await instance.database;
    return await db.update('questions', updatedQuestion, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getQuestions() async {
    final db = await instance.database;
    return await db.query('questions');
  }

  Future<int> deleteQuestion(int id) async {
    final db = await instance.database;
    return await db.delete('questions', where: 'id = ?', whereArgs: [id]);
  }
}
