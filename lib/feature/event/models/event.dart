// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

List<Event> eventFromJson(String str) => List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
    Model model;
    String pk;
    Fields fields;

    Event({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
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
    String bookId;
    String eventName;
    String description;
    String location;
    String posterLink;
    DateTime eventDate;
    DateTime date;

    Fields({
        required this.bookId,
        required this.eventName,
        required this.description,
        required this.location,
        required this.posterLink,
        required this.eventDate,
        required this.date,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        bookId: json["book_id"],
        eventName: json["event_name"],
        description: json["description"],
        location: json["location"],
        posterLink: json["poster_link"],
        eventDate: DateTime.parse(json["event_date"]),
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "event_name": eventName,
        "description": description,
        "location": location,
        "poster_link": posterLink,
        "event_date": "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}

enum Model {
    EVENT_EVENT
}

final modelValues = EnumValues({
    "event.event": Model.EVENT_EVENT
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
