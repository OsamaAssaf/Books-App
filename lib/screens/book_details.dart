import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_books/modules/book.dart';
import 'package:google_books/services/book_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({Key? key, required this.book, required this.index})
      : super(key: key);

  final Book book;
  final int index;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    List<Book> favoriteBooks = context.watch<BookProvider>().favoriteBooks;
    Book current = favoriteBooks.firstWhere(
        (element) => element.id == widget.book.id,
        orElse: () => Book());

    if (widget.book.id == current.id) {
      setState(() {
        _isFavorite = true;
      });
    }

    TextStyle? title = Theme.of(context).textTheme.headline1;
    TextStyle? subtitle = Theme.of(context).textTheme.bodyText1;

    String authors =
        widget.book.authors!.replaceAll('[', '').replaceAll(']', '');
    List<String> authorsList = authors.split(',');

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            actions: [
              IconButton(
                  onPressed: () {
                    if (!_isFavorite) {
                      context.read<BookProvider>().addToFavorite(widget.book);
                      setState(() {
                        _isFavorite = true;
                      });

                      showSnackBar(context, 'Added to favorite', () {
                        context
                            .read<BookProvider>()
                            .deleteFromFavorite(widget.book.id!);
                        setState(() {
                          _isFavorite = false;
                        });
                      });
                    } else {
                      context
                          .read<BookProvider>()
                          .deleteFromFavorite(widget.book.id!);
                      setState(() {
                        _isFavorite = false;
                      });
                      showSnackBar(context, 'Removed from favorite', () {
                        context.read<BookProvider>().addToFavorite(widget.book);
                        setState(() {
                          _isFavorite = true;
                        });
                      });
                    }
                  },
                  icon: !_isFavorite
                      ? const Icon(Icons.star_border)
                      : const Icon(Icons.star)),
            ],
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.book.title!,
                textAlign: TextAlign.left,
              ),
              background: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Hero(
                  tag: widget.index,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              content: Image.network(
                                widget.book.imageLinks!,
                                fit: BoxFit.contain,
                              ),
                            );
                          });
                    },
                    child: Image.network(
                      widget.book.imageLinks!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'Title',
                      style: title,
                    ),
                    Text(
                      widget.book.title!,
                      textAlign: TextAlign.left,
                      style: subtitle,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Subtitle',
                      style: title,
                    ),
                    Text(
                      widget.book.subtitle!,
                      style: subtitle,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Authors',
                      style: title,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: authorsList
                          .map((element) => Text(
                                element.trim(),
                                style: subtitle,
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Description',
                      style: title,
                    ),
                    Text(
                      widget.book.description!,
                      style: subtitle,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Page count: ${widget.book.pageCount}',
                          style: subtitle,
                        ),
                        Text(
                          'Language: ${widget.book.language}',
                          style: subtitle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Published date: ${widget.book.publishedDate}',
                      style: subtitle,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (!await launch(widget.book.infoLink!)) {
                          Fluttertoast.showToast(
                            msg: 'Could not  launch',
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                          );
                        }
                      },
                      child: const Text('Open on store'),
                    ),
                  ],
                ),
              );
            }, childCount: 1),
          )
        ],
      ),
    );
  }

  void showSnackBar(
      BuildContext context, String content, Function() onPressed) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(content),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: onPressed,
      ),
    ));
  }
}
