// top_carousel.dart

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bookshelve_flutter/feature/home/models/book.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:bookshelve_flutter/feature/details/screens/details.dart';
import 'package:google_fonts/google_fonts.dart';

class TopCarousel extends StatelessWidget {
  final List<Book> topBooks;
  final CookieRequest request;

  TopCarousel({required this.topBooks, required this.request});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: topBooks.map((book) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BookDetails(request: request, book: book),
                  ),
                );
              },
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Added for better contrast
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    // Shadow for each carousel item
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(book.fields.bookCoverLink),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    book.fields.bookTitle,
                    style: TextStyle(
                      fontSize: 16.0,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      // For readability
                      color: Colors.white,
                      fontFamily: GoogleFonts.merriweather().fontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        padEnds: false,
        viewportFraction:
            0.8, // Adjust based on how much of each card should be visible
      ),
    );
  }
}
