import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'my_database.db';
  static final _databaseVersion = 1;

  static final String table = 'patient_table';
  static final String  columnId = '_id';
  static final String columnName = 'name';
  static final String columnAge = 'age';
  static final String columnState = 'state';
  static final String columnScreenshotPath = 'screenshot_path';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath() + _databaseName;
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL,
        $columnState TEXT NOT NULL,
        $columnScreenshotPath TEXT NOT NULL
      )
    ''');
  }

   Future<int> insertPatient(Patient patient) async {
    final db = await database;
    return await db.insert(table, patient.toMap());
  }

  Future<List<Patient>> getAllPatients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Patient(
        id: maps[i][columnId],
        name: maps[i][columnName],
        age: maps[i][columnAge],
        state: maps[i][columnState],
        screenshotPath: maps[i][columnScreenshotPath],
      );
    });
  }

  Future<int> updatePatient(Patient patient) async {
    final db = await database;
    return await db.update(
      table,
      patient.toMap(),
      where: '$columnId = ?',
      whereArgs: [patient.id],
    );
  }

  Future<int> deletePatient(int id) async {
    final db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}

class Patient {
  int? id;
  String? name;
  dynamic? age;
  String? state;
  String? screenshotPath;

  Patient({
    this.id,
    this.name,
    this.age,
    this.state,
    this.screenshotPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'state': state,
      'screenshot_path': screenshotPath,

    };
  }

  factory Patient.fromMap(Map<String,
      dynamic> map) {
    return Patient(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      state: map['state'],
      screenshotPath: map['screenshot_path'],
    );
  }

}
