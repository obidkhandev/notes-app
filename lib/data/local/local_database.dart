import 'package:notes_app/data/model/notes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDB {
  static Database? _database;
  static const String tableName = 'notes';

  // Open database connection
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            createdDate TEXT,
            descriptions TEXT,
            noteColor INTEGER
          )
        ''');
      },
    );
  }

  // Get all notes from the database
   Future<List<NotesModel>> getAllNotes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return NotesModel(
        name: maps[i]['name'],
        id: maps[i]["id"],
        createdDate: maps[i]['createdDate'],
        noteColor: maps[i]['noteColor'], descriptions: maps[i]["descriptions"],
      );
    });
  }

  // Delete a note from the database
  Future<void> deleteNote(int id) async {
    final Database db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }


  Future<void> insertNote(NotesModel note) async {
    final Database db = await database;
    await db.insert(tableName, note.toJson());
  }

  Future<void> updateNote(int id,NotesModel notesModel) async {
    final Database db = await database;
    await db.update(
      tableName,
      notesModel.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // Delete all notes from the database
  Future<void> deleteAllNotes() async {
    final Database db = await database;
    await db.delete(tableName);
  }
}
