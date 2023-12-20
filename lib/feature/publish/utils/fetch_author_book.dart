import 'dart:convert';

import 'package:bookshelve_flutter/feature/event/models/book.dart';
import 'package:bookshelve_flutter/feature/publish/models/author_book.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:http/http.dart' as http;

Future<List<Book>> fetchAuthorBook(CookieRequest request) async {
  var response = await request.get(
    'http://localhost:8000/book/author/json/flutter/',
  );

  // Decode response into JSON
  var data = jsonDecode(response['books']);

  // Convert JSON data into AuthorBook instance
  List<Book> author_book = [];
  for (var d in data) {
    if (d != null) {
      author_book.add(Book.fromJson(d));
    }
  }

  return author_book;
}
