
import 'dart:convert';

import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';

Future<dynamic> publishAuthorBook(CookieRequest request, String book_title, String description, String book_cover_link, BuildContext context, mounted) async {
  final response = await request.postJson('http://localhost:8000/book/publish-flutter/', 
  jsonEncode(<String, String>{
    'book_title': book_title,
    'description': description,
    'book_cover_link': book_cover_link,
  }));
  return response;
}