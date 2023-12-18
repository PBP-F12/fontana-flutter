// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    String model;
    int pk;
    Fields fields;

    Review({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
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
    String bookId;
    int userId;
    String reviewText;
    int reviewRating;

    Fields({
        required this.bookId,
        required this.userId,
        required this.reviewText,
        required this.reviewRating,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        bookId: json["book_id"],
        userId: json["user_id"],
        reviewText: json["review_text"],
        reviewRating: json["review_rating"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "user_id": userId,
        "review_text": reviewText,
        "review_rating": reviewRating,
    };
}
