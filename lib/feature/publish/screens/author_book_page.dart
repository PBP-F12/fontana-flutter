import 'dart:ui' as ui;

import 'package:bookshelve_flutter/feature/details/screens/details.dart';
import 'package:bookshelve_flutter/feature/event/models/book.dart';
import 'package:bookshelve_flutter/feature/publish/models/author_book.dart';
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
      backgroundColor: const Color.fromARGB(255, 200, 174, 125),
      appBar: AppBar(
        title: const Text(
          'My Books',
          style: TextStyle(
            fontWeight: FontWeight.w600
          )
        ),
        backgroundColor: const Color.fromARGB(255, 200, 174, 125),
      ),
      body: FutureBuilder(
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
                      style:
                          TextStyle(
                            color: Color(0xFF3E2723), 
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontFamily: GoogleFonts.merriweather().fontFamily,
                          ),
                  ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                String book_title = snapshot.data![index].fields.bookTitle;
                String description = snapshot.data![index].fields.description;
                double rating = snapshot.data![index].fields.avgRating;
                String book_cover_link = snapshot.data![index].fields.bookCoverLink;
                return Center(
                  child: Card(
                    margin: EdgeInsets.fromLTRB(32.0, 20.0, 25.0, 20.0),
                    color: Colors.brown.shade100,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        Container( 
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              colors: [Colors.brown.shade300, Colors.brown.shade200],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.brown,
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child: CustomPaint(
                            size: Size(100, 150),
                            painter: CustomCardShapePainter(10, Colors.brown.shade300, Colors.brown.shade200),
                          ),
                        ),
                        Positioned.fill(
                          child: Row(
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: book_cover_link,
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book_title,
                                      style: TextStyle(
                                        color: Colors.brown.shade700,
                                        fontWeight: FontWeight.w700),
                                      overflow: TextOverflow.fade,
                                      ),
                                    Text(
                                      description,
                                      style: TextStyle(
                                        color: Colors.brown.withOpacity(0.8),
                                        fontSize: 13.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rate_rounded,
                                          color: Colors.yellow.shade100,
                                          size: 16,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          rating.toString(),
                                          style: TextStyle(
                                            color: Colors.brown,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            );
          } else {
            return const Text('nothing');
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
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
        ),
        backgroundColor: Colors.brown.shade200,
      ),
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}