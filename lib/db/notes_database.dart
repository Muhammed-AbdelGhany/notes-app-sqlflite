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
    final id = await db.insert('notes', note.toJson());

    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final map = await db.query(
      'notes',
      columns: ['_id', 'isImportant', 'number', 'title', 'decription', 'time'],
      where: '_id = ? ',
      whereArgs: [id],
    );

    if (map.isNotEmpty) {
      return Note.fromJson(map.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final result = await db.query('notes', orderBy: 'time ASC');

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    return await db.update(
      'notes',
      note.toJson(),
      where: '_id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return await db.delete(
      'notes',
      where: '_id = ?',
      whereArgs: [id],
    );
  }

  Future closeDatabase() async {
    final db = await instance.database;
    db.close();
  }
}
