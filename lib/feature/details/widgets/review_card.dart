import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookshelve_flutter/feature/details/widgets/usermanager.dart';

class ReviewCard extends StatelessWidget {
  final int reviewerId;
  final String reviewText;
  final String avgRating;

  const ReviewCard({
    Key? key,
    required this.reviewerId,
    required this.reviewText,
    required this.avgRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        color: Color.fromARGB(255, 202, 186, 156),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Increased roundness
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String>(
                    future: getUserName(reviewerId), // Using getUserName function
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.merriweather().fontFamily,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.merriweather().fontFamily,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return Text(
                          snapshot.data!, // Display the fetched name
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.merriweather().fontFamily,
                          ),
                        );
                      } else {
                        return Text(
                          'No reviewer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.merriweather().fontFamily,
                          ),
                        );
                      }
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        avgRating,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontFamily: GoogleFonts.merriweather().fontFamily,
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 255, 163, 83),
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 100), // Set the maximum height
                child: SingleChildScrollView(
                  child: Text(
                    reviewText,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.merriweather().fontFamily,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
