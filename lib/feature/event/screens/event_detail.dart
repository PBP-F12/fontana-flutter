import 'package:bookshelve_flutter/feature/event/models/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookshelve_flutter/feature/event/models/event.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventId;

  const EventDetailsPage({Key? key, required this.eventId}) : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late Future<Event> eventFuture;
  late Future<Book> bookFuture;

  @override
  void initState() {
    super.initState();
    eventFuture = fetchEvent();
  }

  Future<Event> fetchEvent() async {
    var url = Uri.parse('http://127.0.0.1:8000/event/json/${widget.eventId}/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    Event event = Event.fromJson(data[0]); // Assuming the response is a list with one item
    bookFuture = fetchBook(event.fields.bookId); // Fetch book details
    return event;
  }

  Future<Book> fetchBook(String bookId) async {
    var url = Uri.parse('http://127.0.0.1:8000/json/$bookId/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    return Book.fromJson(data[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Event'),
      ),
      body: FutureBuilder<Event>(
        future: eventFuture,
        builder: (context, eventSnapshot) {
          if (!eventSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return FutureBuilder<Book>(
              future: bookFuture,
              builder: (context, bookSnapshot) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: <Widget>[
                    Text(
                      eventSnapshot.data!.fields.eventName,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text("Event Date: ${eventSnapshot.data!.fields.eventDate}"),
                    const SizedBox(height: 10),
                    Text("Location: ${eventSnapshot.data!.fields.location}"),
                    const SizedBox(height: 10),
                    Text("Description: ${eventSnapshot.data!.fields.description}"),
                    const SizedBox(height: 10),
                    if (bookSnapshot.hasData)
                      Text("Book Description: ${bookSnapshot.data!.fields.description}"),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
