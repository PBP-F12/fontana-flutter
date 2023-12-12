import 'package:bookshelve_flutter/feature/event/screens/create_event.dart';
import 'package:bookshelve_flutter/feature/event/screens/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookshelve_flutter/feature/event/models/event.dart';
import 'package:bookshelve_flutter/feature/home/widgets/left_drawer.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Future<List<Event>> fetchEvent() async {
    var url = Uri.parse('http://127.0.0.1:8000/event/json/');
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
      appBar: AppBar(
        title: const Text('Events'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchEvent(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "No events available.",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
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
                          builder: (context) => EventDetailsPage(eventId: event.pk),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.fields.eventName,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // const SizedBox(height: 8),
                          // Text(event.fields.eventDate),
                          const SizedBox(height: 8),
                          Text(event.fields.description),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEventPage(), // Assuming you have this page
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
