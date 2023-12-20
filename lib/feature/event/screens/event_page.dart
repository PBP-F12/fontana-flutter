import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookshelve_flutter/feature/event/models/event.dart';
import 'package:bookshelve_flutter/feature/home/widgets/left_drawer.dart';
import 'package:bookshelve_flutter/feature/event/screens/event_detail.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:bookshelve_flutter/feature/event/screens/create_event.dart'; // Assuming you have this page

class EventPage extends StatefulWidget {
  final CookieRequest request;

  const EventPage(this.request, {Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState(request);
}

class _EventPageState extends State<EventPage> {
  CookieRequest request;

  _EventPageState(this.request);

  Future<List<Event>> fetchEvent() async {
    var url = Uri.parse('http://localhost:8000/event/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Event> list_event = [];
    for (var d in data) {
      if (d != null) {
        list_event.add(Event.fromJson(d));
      }
    }
    return list_event;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc8ae7d),
      appBar: AppBar(
        title: Text('Events',
            style:
                TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontFamily: GoogleFonts.merriweather().fontFamily)),
        backgroundColor: Color.fromARGB(255, 132, 112, 73)
      ),
      drawer: LeftDrawer(request),
      body: Column(
        children: [
          Stack(
            children: [
              // Background Image
              Container(
                height: 200, // Set the desired height
                width: double.infinity,
                child: Image.asset(
                  'assets/images/library_bg.jpg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              // Dark overlay for better text readability
              Container(
                height: 200,
                width: double.infinity,
                color:
                    Colors.black.withOpacity(0.5), // Adjust opacity as needed
              ),
              // Text in the dead center of the image
              Positioned.fill(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Event',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 234, 198, 150),
                          fontFamily: GoogleFonts.merriweather().fontFamily,
                        ),
                      ),
                      SizedBox(
                          height:
                              8), // Adjust the spacing between the two texts
                      Text(
                        'Unleash The Stories; Share and Connect.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 234, 198, 150),
                          fontFamily: GoogleFonts.merriweather().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: fetchEvent(),
            builder: (context, AsyncSnapshot<List<Event>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text(
                    "No events available.",
                    style: TextStyle(
                        color: Color(0xff59A5D8),
                        fontSize: 20,
                        fontFamily: GoogleFonts.merriweather().fontFamily),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      var event = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventDetailsPage(eventId: event.pk),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (event.fields.posterLink.isNotEmpty)
                                  Image.network(
                                    event.fields.posterLink,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return const Text('Image not available');
                                    },
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  event.fields.eventName,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.merriweather().fontFamily,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                    '${event.fields.eventDate.year}/${event.fields.eventDate.month}/${event.fields.eventDate.day}',
                                    style: TextStyle(
                                        fontFamily: GoogleFonts.merriweather()
                                            .fontFamily)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: request.isAdmin() ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEventPage(request),
            ),
          );
        },
        child: const Icon(Icons.add),
      ) : SizedBox(height: 0),
    );
  }
}
