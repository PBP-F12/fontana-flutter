import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookshelve_flutter/feature/event/models/event.dart';
import 'package:bookshelve_flutter/feature/event/models/book.dart';

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
    var url = Uri.parse('http://localhost:8000/event/json/${widget.eventId}/');
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
    var url = Uri.parse('http://localhost:8000/json/$bookId/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    return Book.fromJson(data[0]);
  }

  Widget _detailBox(String title, String content, {String? imageUrl}) {
  return Container(
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        if (imageUrl != null)
          Center(
            child: SizedBox(
              height: 200, // Set your desired height
              width: 150, // Set your desired width
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(height: 8),
        Text(content),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc8ae7d),
      appBar: AppBar(
        title: Text('Event Details',
            style:
                TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontFamily: GoogleFonts.merriweather().fontFamily)),
        backgroundColor: Color.fromARGB(255, 132, 112, 73)
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
                return Column(
                  children: [
                    Stack(
                      children: [
                        // Background Image
                        Container(
                          height: 200, // Set the desired height
                          width: double.infinity,
                          child: Image.network(
                            eventSnapshot.data!.fields.posterLink, // Replace with your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Dark overlay for better text readability
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
                        ),
                        // Text in the center of the image
                        Positioned.fill(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  eventSnapshot.data!.fields.eventName,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: GoogleFonts.merriweather().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: <Widget>[
                          _detailBox(
                            "Event Details",
                            "Date: ${eventSnapshot.data!.fields.eventDate.year}/${eventSnapshot.data!.fields.eventDate.month}/${eventSnapshot.data!.fields.eventDate.day}\nLocation: ${eventSnapshot.data!.fields.location}",
                          ),
                          _detailBox(
                            "Event Description",
                            eventSnapshot.data!.fields.description,
                          ),
                          if (bookSnapshot.hasData)
                            _detailBox(
                              "Event's Book Preview",
                              bookSnapshot.data!.fields.description,
                              imageUrl: bookSnapshot.data!.fields.bookCoverLink,
                            ),
                        ],
                      ),
                    ),
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
