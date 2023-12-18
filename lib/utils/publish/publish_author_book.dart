import 'package:bookshelve_flutter/models/publish/author_book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

Future<AuthorBook> publishAuthorBook(AuthorBook authorBook) async {
  var url = Uri.parse(
      'https://fontana.my.id/book/publish/');
  var response = await http.post(
    url,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(authorBook.toJson()),
  );
  return AuthorBook.fromJson(jsonDecode(response.body));
}

void publishAuthorBook2(request, String book_title, String description, String book_cover_link, BuildContext context, mounted) async {
  final response = await request.post('https://fontana.my.id/book/publish/', {
    'book_title': book_title,
    'description': description,
    'book_cover_link': book_cover_link,
  });
}