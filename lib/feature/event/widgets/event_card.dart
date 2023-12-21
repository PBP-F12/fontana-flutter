import 'package:bookshelve_flutter/feature/event/models/event.dart';
import 'package:bookshelve_flutter/feature/event/screens/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
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
              if (event.fields.posterLink.isNotEmpty)
                Image.network(
                  event.fields.posterLink,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
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
                  fontFamily: GoogleFonts.merriweather().fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                  '${event.fields.eventDate.year}/${event.fields.eventDate.month}/${event.fields.eventDate.day}',
                  style: TextStyle(
                      fontFamily: GoogleFonts.merriweather().fontFamily)),
            ],
          ),
        ),
      ),
    );
  }
}
