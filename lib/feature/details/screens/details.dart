import 'package:bookshelve_flutter/feature/details/models/book_details.dart';
import 'package:bookshelve_flutter/feature/publish/utils/fetch_author_book.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/feature/home/models/book.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookshelve_flutter/feature/details/widgets/review_card.dart';
import 'package:bookshelve_flutter/feature/details/models/review.dart';
import 'package:bookshelve_flutter/feature/details/widgets/reviewservice.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:bookshelve_flutter/feature/details/screens/add_review.dart';
import 'package:bookshelve_flutter/feature/details/widgets/usermanager.dart';
import 'package:bookshelve_flutter/feature/details/widgets/bookmark_button.dart';

class BookDetails extends StatefulWidget {
  final CookieRequest request;
  final String bookId;

  const BookDetails({super.key, required this.request, this.bookId = ''});

  @override
  State<BookDetails> createState() =>
      _BookDetailsState(request: request, bookId: bookId);
}

class _BookDetailsState extends State<BookDetails> {
  final CookieRequest request;
  final String bookId;
  late Future<BookDetail> futureBook;

  _BookDetailsState({required this.request, required this.bookId});

  @override
  void initState() {
    super.initState();

    futureBook = request.getDetailBook(bookId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBook,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('error'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('no data'));
          }

          // return const Text('data');
          BookDetail bookData = snapshot.data!;

          return Stack(
            children: [
              Scaffold(
                backgroundColor: const Color.fromARGB(255, 200, 174, 125),
                appBar: AppBar(
                  title: Text(
                    bookData.title,
                    style: TextStyle(
                        fontFamily: GoogleFonts.merriweather().fontFamily,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: const Color.fromARGB(74, 255, 255, 255),
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            height: 370,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [
                                  0.2,
                                  1.0,
                                ],
                                colors: [
                                  Color.fromARGB(255, 60, 47,
                                      25), // Darker color at the top
                                  Color.fromARGB(255, 200, 174,
                                      125), // Lighter color at the bottom
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                            child: Container(
                              height: 300, // Height of the image container
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(bookData.image),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              bookData.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontFamily:
                                    GoogleFonts.merriweather().fontFamily,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              bookData.author.username,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                                fontFamily:
                                    GoogleFonts.merriweather().fontFamily,
                              ),
                            ),
                            const SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                    fontFamily:
                                        GoogleFonts.merriweather().fontFamily,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      bookData.rating.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                        fontFamily: GoogleFonts.merriweather()
                                            .fontFamily,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 255, 163, 83),
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              constraints: const BoxConstraints(maxHeight: 300),
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 16),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(98, 206, 206, 206),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  bookData.description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                    fontFamily:
                                        GoogleFonts.merriweather().fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontFamily:
                                    GoogleFonts.merriweather().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // FutureBuilder and review cards in a separate Padding
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: FutureBuilder<List<Review>>(
                          future: ReviewService().fetchReviews(bookId, request),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.data != null &&
                                snapshot.data!.isEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'No reviews available.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 66, 66, 66),
                                      fontFamily:
                                          GoogleFonts.merriweather().fontFamily,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  FloatingActionButton.extended(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    backgroundColor: const Color(0xFF765827),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddReview(
                                              bookDetail: bookData,
                                              request: request),
                                        ),
                                      );
                                    },
                                    label: Text(
                                      'Add Review',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: GoogleFonts.merriweather()
                                            .fontFamily,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // List of review cards
                                  ...snapshot.data!
                                      .map((review) => ReviewCard(
                                            reviewerId: review.fields.userId,
                                            reviewText:
                                                review.fields.reviewText,
                                            avgRating: review
                                                .fields.reviewRating
                                                .toString(),
                                          ))
                                      .toList(),

                                  // Add Review button
                                  SizedBox(height: 16),
                                  Center(
                                    child: FloatingActionButton.extended(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      backgroundColor: const Color(0xFF765827),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddReview(
                                                bookDetail: bookData,
                                                request: request),
                                          ),
                                        );
                                      },
                                      label: Text(
                                        'Add Review',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontFamily: GoogleFonts.merriweather()
                                              .fontFamily,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: BookmarkButton(
                  request: request,
                  bookId: bookData.id, // Assuming book.pk is the book ID
                ),
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('failed to fetch'),
          );
        }
      },
    );
  }
}
