// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

import 'dart:convert';

List<Forum> forumFromJson(String str) =>
    List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

String forumToJson(List<Forum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
  String forumId;
  String forumDetailLink;
  String forumTitle;
  Book book;
  int creatorId;
  String creatorUsername;
  int numberOfComments;

  Forum({
    required this.forumId,
    required this.forumDetailLink,
    required this.forumTitle,
    required this.book,
    required this.creatorId,
    required this.creatorUsername,
    required this.numberOfComments,
  });

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        forumId: json["forumId"],
        forumDetailLink: json["forumDetailLink"],
        forumTitle: json["forumTitle"],
        book: Book.fromJson(json["book"]),
        creatorId: json['creatorId'],
        creatorUsername: json["creatorUsername"],
        numberOfComments: json["numberOfComments"],
      );

  Map<String, dynamic> toJson() => {
        "forumId": forumId,
        "forumDetailLink": forumDetailLink,
        "forumTitle": forumTitle,
        "book": book.toJson(),
        "creatorUsername": creatorUsername,
        "numberOfComments": numberOfComments,
      };
}

class Book {
  String cover;
  String title;

  Book({
    required this.cover,
    required this.title,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        cover: json["cover"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "cover": cover,
        "title": title,
      };
}
