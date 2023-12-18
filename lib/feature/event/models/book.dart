// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    String pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
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

enum Model {
    MAIN_BOOK
}

final modelValues = EnumValues({
    "main.book": Model.MAIN_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
