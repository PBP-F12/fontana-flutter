import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/feature/home/models/book.dart'; // Import your Book model

class BookDetails extends StatelessWidget {
  final Book book;

  BookDetails({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.fields.bookTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: book.fields.bookCoverLink.isNotEmpty
                  ? Image.network(
                      book.fields.bookCoverLink,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.5,
                    )
                  : Image.asset(
                      'assets/images/placeholder.png', // Placeholder image
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                book.fields.bookTitle,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Author ID: ${book.fields.authorId}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Average Rating: ${book.fields.avgRating.toString()}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Description:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                book.fields.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
