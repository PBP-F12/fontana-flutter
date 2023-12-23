import 'package:bookshelve_flutter/constant/color.dart';
import 'package:bookshelve_flutter/constant/urls.dart';
import 'package:bookshelve_flutter/feature/event/widgets/event_card.dart';
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
    var url = Uri.parse('${Urls.backendUrl}/event/json/');
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
      drawer: LeftDrawer(request),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Background Image
                Container(
                  height: 200, // Set the desired height
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/event.jpg', // Replace with your image path
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
                            fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
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
                  List<Event> events = snapshot.data!;

                  return Column(children: [
                    for (var event in events)
                      EventCard(
                        event: event,
                      )
                  ]);
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: request.isAdmin()
          ? Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: FloatingActionButton(
                backgroundColor: FontanaColor.brown2,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateEventPage(request),
                    ),
                  );
                },
                child: const Icon(Icons.add, color: FontanaColor.creamy0),
              ),
            )
          : SizedBox(height: 0),
    );
  }
}
