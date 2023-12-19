// To parse this JSON data, do
//
//     final authorBook = authorBookFromJson(jsonString);

import 'dart:convert';

List<AuthorBook> authorBookFromJson(String str) => List<AuthorBook>.from(json.decode(str).map((x) => AuthorBook.fromJson(x)));

String authorBookToJson(List<AuthorBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorBook {
    String model;
    String pk;
    Fields fields;

    AuthorBook({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory AuthorBook.fromJson(Map<String, dynamic> json) => AuthorBook(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int authorId;
    String bookTitle;
    String description;
    double avgRating;
    int numRating;
    String bookCoverLink;
    String bookCoverFile;

    Fields({
        required this.authorId,
        required this.bookTitle,
        required this.description,
        required this.avgRating,
        required this.numRating,
        required this.bookCoverLink,
        required this.bookCoverFile,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        authorId: json["author_id"],
        bookTitle: json["book_title"],
        description: json["description"],
        avgRating: json["avg_rating"]?.toDouble(),
        numRating: json["num_rating"],
        bookCoverLink: json["book_cover_link"],
        bookCoverFile: json["book_cover_file"],
    );

    Map<String, dynamic> toJson() => {
        "author_id": authorId,
        "book_title": bookTitle,
        "description": description,
        "avg_rating": avgRating,
        "num_rating": numRating,
        "book_cover_link": bookCoverLink,
        "book_cover_file": bookCoverFile,
    };
}
