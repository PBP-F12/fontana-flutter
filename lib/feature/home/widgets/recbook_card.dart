import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookshelve_flutter/feature/home/models/book.dart';
import 'package:bookshelve_flutter/feature/details/screens/details.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';

class RecommendedBookCard extends StatelessWidget {
  final Book book;
  final CookieRequest request;

  RecommendedBookCard({required this.book, required this.request});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetails(book: book, request: request),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color.fromARGB(255, 200, 174, 125),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  book.fields.bookCoverLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                book.fields.bookTitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontFamily: GoogleFonts.merriweather().fontFamily,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}