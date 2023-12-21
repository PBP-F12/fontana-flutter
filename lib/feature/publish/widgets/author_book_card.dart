import 'package:bookshelve_flutter/feature/details/screens/details.dart';
import 'package:bookshelve_flutter/feature/event/models/book.dart';
import 'package:bookshelve_flutter/feature/publish/utils/custom_card_shape_painter.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorBookCard extends StatelessWidget {
  final Book book;

  const AuthorBookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BookDetails(bookId: book.pk, request: request),
            ),
          );
        },
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
                  painter: CustomCardShapePainter(
                      10, Colors.brown.shade300, Colors.brown.shade200),
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: book.fields.bookCoverLink,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.fields.bookTitle,
                            style: TextStyle(
                                color: Colors.brown.shade700,
                                fontWeight: FontWeight.w700),
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            book.fields.description,
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
                                book.fields.avgRating.toString(),
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
      ),
    );
  }
}
