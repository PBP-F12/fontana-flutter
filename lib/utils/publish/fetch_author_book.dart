import 'dart:convert';

import 'package:bookshelve_flutter/models/publish/author_book.dart';
import 'package:http/http.dart' as http;

Future<List<AuthorBook>> fetchAuthorBook() async {
  var url =
    Uri.parse('http://127.0.0.1:8000/book/author/json/');
  var response = await http.get(
    url,
    headers: {
      // 'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    },
  );

  // Decode response into JSON
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // Convert JSON data into AuthorBook instance
  List<AuthorBook> author_book = [];
  for (var d in data) {
    if (d != null) {
      author_book.add(AuthorBook.fromJson(d));
    }
  }
  return author_book;
}
