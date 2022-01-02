import 'package:flutter/material.dart';
import 'package:google_books/modules/book.dart';
import 'package:google_books/screens/book_details.dart';

class BooksListView extends StatelessWidget {
  const BooksListView({Key? key, required this.data}) : super(key: key);
  final List<Book> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 125,
            child: InkWell(
              child: Card(
                color: Theme.of(context).cardColor,
                elevation: 10.0,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      width: 100,
                      height: 125,
                      child: Hero(
                        tag: index,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                            data[index].imageLinks!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            data[index].subtitle!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(data[index].pageCount.toString() + ' page'),
                            Text(data[index].language!),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        BookDetails(book: data[index], index: index)));
              },
            ),
          ),
        );
      },
    );
  }
}
