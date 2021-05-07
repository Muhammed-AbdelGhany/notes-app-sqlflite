import 'package:notesApp_sqllite/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database _database;
  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB('notes.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    db.execute(
        ' CREATE TABLE notes (_id INTEGER PRIMARY KEY AUTOINCREMENT , isImportant BOOLEAN NOT NULL , number INTEGER NOT NULL , title TEXT NOT NULL , decription  TEXT NOT NULL , time TEXT NOT NULL ) ');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    db.insert('notes', note.toJson());
  }

  Future closeDatabase() async {
    final db = await instance.database;
    db.close();
  }
}
