import 'package:bookshelve_flutter/constant/color.dart';
import 'package:bookshelve_flutter/feature/details/screens/details.dart';
import 'package:bookshelve_flutter/feature/event/models/book.dart';
import 'package:bookshelve_flutter/feature/publish/widgets/author_book_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:bookshelve_flutter/feature/publish/screens/publish_form_page.dart';
import 'package:bookshelve_flutter/feature/publish/utils/fetch_author_book.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorBookPage extends StatefulWidget {
  final CookieRequest request;

  AuthorBookPage(this.request, {super.key});

  @override
  State<AuthorBookPage> createState() => _AuthorBookPageState(request);
}

class _AuthorBookPageState extends State<AuthorBookPage> {
  CookieRequest request = CookieRequest();
  late Future<List<Book>> authorBooks;

  _AuthorBookPageState(CookieRequest request) {
    this.request = request;
  }

  @override
  void initState() {
    super.initState();
    authorBooks = fetchAuthorBook(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FontanaColor.creamy2,
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
                    'images/book_collection_bg.jpg', // Replace with your image path
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
                          'Your Books',
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
                          'Marks you have left in your journey',
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
                future: authorBooks,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          "You have not published any book yet.",
                          style: TextStyle(
                            color: Color(0xFF3E2723),
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontFamily: GoogleFonts.merriweather().fontFamily,
                          ),
                        ),
                      );
                    }
                    List<Book> authorBooks = snapshot.data!;

                    return Column(
                      children: [
                        for (var authorBook in authorBooks)
                          AuthorBookCard(book: authorBook)
                      ],
                    );
                  } else {
                    return const Text('nothing');
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 45),
        child: FloatingActionButton(
          onPressed: () async {
            // Navigate to the forum creation page and wait for the result
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PublishFormPage(request),
              ),
            );

            setState(() {
              authorBooks = fetchAuthorBook(request);
            });
          },
          child: Icon(
            Icons.add,
            color: FontanaColor.creamy0,
          ),
          backgroundColor: Colors.brown.shade200,
        ),
      ),
    );
  }
}
