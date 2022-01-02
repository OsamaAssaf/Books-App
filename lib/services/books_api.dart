import 'dart:convert';

import 'package:google_books/modules/book.dart';
import 'package:http/http.dart' as http;

class BooksApi {
  Future fetchData(String searchWord) async {
    Uri url =
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$searchWord');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List booksList = jsonData['items'];
      List<Book> books = [];

      for (int i = 0; i < booksList.length; i++) {
        books.add(
          Book(
              id: booksList[i]['id'],
              title: booksList[i]['volumeInfo']['title'] ?? ' No Title',
              subtitle:
                  booksList[i]['volumeInfo']['subtitle'] ?? ' No subtitle',
              authors: booksList[i]['volumeInfo']['authors'].length == 0 ?'No authors':booksList[i]['volumeInfo']['authors'].toString(),
              publishedDate: booksList[i]['volumeInfo']['publishedDate'],
              description: booksList[i]['volumeInfo']['description'] ??
                  ' No description',
              pageCount: booksList[i]['volumeInfo']['pageCount'],
              imageLinks: booksList[i]['volumeInfo']['imageLinks']['thumbnail'],
              language: booksList[i]['volumeInfo']['language'],
              infoLink: booksList[i]['volumeInfo']['infoLink']),
        );
      }
      return books;
    } else {
      throw Exception(
          'Failed to load books/ statusCode=${response.statusCode}');
    }
  }
}
