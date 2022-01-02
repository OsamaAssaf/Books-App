import 'package:google_books/modules/book.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 2;
  static const String _tableName = 'favoriteBooks';

  static initDb() async {
    if (_db != null) {
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'book.db';
        _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (Database db, int version) async {
            await db.execute('CREATE TABLE $_tableName '
                '('
                'id INTEGER, '
                'title TEXT, '
                'subtitle TEXT, '
                'authors STRING, '
                'publishedDate TEXT, '
                'description TEXT, '
                'pageCount INTEGER, '
                'imageLinks TEXT, '
                'language TEXT, '
                'infoLink TEXT'
                ')');
          },
        );
      } catch (e) {
        throw e.toString();
      }
    }
  }

  static Future<int> insert(Book book) async {
    try {
      return await _db!.insert(_tableName, book.toJson());
    } catch (e) {
      return -1;
    }
  }

  static Future<List<Map<String, Object?>>> query() async {
    return await _db!.query(_tableName);
  }

  static delete(String id) async {
    await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
