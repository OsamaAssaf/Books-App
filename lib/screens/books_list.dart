import 'package:flutter/material.dart';
import 'package:google_books/services/books_api.dart';
import 'package:google_books/widgets/book_list_widget.dart';

class BooksList extends StatefulWidget {
  const BooksList({Key? key, required this.searchWord}) : super(key: key);
  final String searchWord;

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.searchWord),
      ),
      body: buildFutureBuilder(widget.searchWord),
    );
  }

  FutureBuilder<dynamic> buildFutureBuilder(String searchWord) {
    return FutureBuilder(
      future: BooksApi().fetchData(searchWord),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            return BooksListView(
              data: snapshot.data,
            );
          } else {
            return Center(
              child: Text(
                'There is no books or no connection, please check your connection!',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            );
          }
        }
      },
    );
  }
}
