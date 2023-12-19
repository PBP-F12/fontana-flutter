import 'dart:convert';

import 'package:bookshelve_flutter/feature/publish/models/author_book.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:http/http.dart' as http;

Future<List<AuthorBook>> fetchAuthorBook(CookieRequest request) async {
  var response = await request.get(
    'http://localhost:8000/book/author/json/flutter/',
  );

  print("somethinc");
  print(response);
  // Decode response into JSON
  print('data books');
  print(response['books']);
  print(response.runtimeType); // Print the type of the variable

  var data = jsonDecode(response['books']);
  print(data.runtimeType);
  if (data is List) {
    print('response["books"] is a List');
  } else {
    print('response["books"] is not a List');
  }
  

  // Convert JSON data into AuthorBook instance
  List<AuthorBook> author_book = [];
  for (var d in data) {
    print('d is here');
    print(d);
    if (d != null) {
      author_book.add(AuthorBook.fromJson(d));
    }
  }

  print('author books');
  print(author_book);

  return author_book;
}
