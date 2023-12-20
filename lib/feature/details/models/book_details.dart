// To parse this JSON data, do
//
//     final bookDetail = bookDetailFromJson(jsonString);

import 'dart:convert';

BookDetail bookDetailFromJson(String str) =>
    BookDetail.fromJson(json.decode(str));

String bookDetailToJson(BookDetail data) => json.encode(data.toJson());

class BookDetail {
  String id;
  String title;
  String image;
  double rating;
  String description;
  Author author;

  BookDetail({
    required this.id,
    required this.title,
    required this.image,
    required this.rating,
    required this.description,
    required this.author,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) => BookDetail(
        id: json['id'],
        title: json["title"],
        image: json["image"],
        rating: json["rating"]?.toDouble(),
        description: json["description"],
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "rating": rating,
        "description": description,
        "author": author.toJson(),
      };
}

class Author {
  String username;

  Author({
    required this.username,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
