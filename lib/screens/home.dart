import 'package:flutter/material.dart';
import 'package:google_books/modules/book.dart';
import 'package:google_books/screens/books_list.dart';
import 'package:google_books/services/book_provider.dart';
import 'package:google_books/services/themes.dart';
import 'package:google_books/widgets/book_list_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<BookProvider>().getFromFavorite();
    context.read<Themes>().getTheme();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<Themes>().isDark;

    List<Book> favoriteBooks = context.watch<BookProvider>().favoriteBooks;
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Google Books'),
      ),
      body: Column(
        children: [
          _searchBar(context, searchController),
          if (favoriteBooks.isEmpty)
            Center(
              child: Text(
                'There is no favorite books add some.',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: BooksListView(
              data: favoriteBooks,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text('Google books'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Theme'),
                    Row(
                      children: [
                        const Text('Light'),
                        Switch.adaptive(
                            value: isDark,
                            onChanged: (bool newValue) async {
                              await context.read<Themes>().setTheme(newValue);
                              if (context.mounted) {
                                await context.read<Themes>().getTheme();
                              }
                            }),
                        const Text('Dark'),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                title: const Text('Close'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _searchBar(BuildContext context, TextEditingController searchController) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, left: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            IconButton(
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BooksList(searchWord: searchController.text)));
                }
              },
              icon: Icon(
                Icons.search_outlined,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
