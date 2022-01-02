import 'package:flutter/foundation.dart';
import 'package:google_books/db/db_helper.dart';
import 'package:google_books/modules/book.dart';

class BookProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Book> favoriteBooks = [];

  addToFavorite(Book book) async {
    await DBHelper.insert(book);
    getFromFavorite();
  }

  getFromFavorite() async {
    final List<Map<String, Object?>> books = await DBHelper.query();
    favoriteBooks = books.map((e) => Book.fromJson(e)).toList();

    notifyListeners();
  }

  deleteFromFavorite(String id) async {
    await DBHelper.delete(id);
    getFromFavorite();
  }
}
