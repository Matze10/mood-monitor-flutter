import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/mood_entry.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'mood_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mood_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        mood INTEGER NOT NULL,
        hoursSlept REAL NOT NULL,
        hasAnxiety INTEGER NOT NULL,
        hasIrritability INTEGER NOT NULL,
        medication TEXT NOT NULL,
        hasAlcoholDrugs INTEGER NOT NULL,
        exerciseMinutes INTEGER NOT NULL,
        stressors TEXT NOT NULL,
        activities TEXT NOT NULL,
        hasEaten INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertMoodEntry(MoodEntry entry) async {
    final db = await database;
    return await db.insert('mood_entries', entry.toMap());
  }

  Future<List<MoodEntry>> getAllMoodEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'mood_entries',
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) => MoodEntry.fromMap(maps[i]));
  }

  Future<MoodEntry?> getMoodEntryByDate(DateTime date) async {
    final db = await database;
    final dateString = date.toIso8601String().split('T')[0];
    final List<Map<String, dynamic>> maps = await db.query(
      'mood_entries',
      where: 'date LIKE ?',
      whereArgs: ['$dateString%'],
    );
    if (maps.isNotEmpty) {
      return MoodEntry.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateMoodEntry(MoodEntry entry) async {
    final db = await database;
    return await db.update(
      'mood_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> deleteMoodEntry(int id) async {
    final db = await database;
    return await db.delete(
      'mood_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<MoodEntry>> getMoodEntriesInRange(DateTime start, DateTime end) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'mood_entries',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) => MoodEntry.fromMap(maps[i]));
  }

  Future<void> deleteAllEntries() async {
    final db = await database;
    await db.delete('mood_entries');
  }
}