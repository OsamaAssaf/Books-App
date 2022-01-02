class Book {
  String? id;
  String? title;
  String? subtitle;
  String? authors;
  String? publishedDate;
  String? description;
  int? pageCount;
  String? imageLinks;
  String? language;
  String? infoLink;

  Book(
      {this.id,
      this.title,
      this.subtitle,
      this.authors,
      this.publishedDate,
      this.description,
      this.pageCount,
      this.imageLinks,
      this.language,
      this.infoLink});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'publishedDate': publishedDate,
      'description': description,
      'pageCount': pageCount,
      'imageLinks': imageLinks,
      'language': language,
      'infoLink': infoLink,
    };
  }

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    authors = json['authors'];
    publishedDate = json['publishedDate'];
    description = json['description'];
    pageCount = json['pageCount'];
    imageLinks = json['imageLinks'];
    language = json['language'];
    infoLink = json['infoLink'];
  }
}
