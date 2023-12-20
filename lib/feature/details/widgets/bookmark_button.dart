// bookmark_button.dart
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart'; // Import the CookieRequest

class BookmarkButton extends StatefulWidget {
  final CookieRequest request;
  final String bookId;

  const BookmarkButton({
    Key? key,
    required this.request,
    required this.bookId,
  }) : super(key: key);

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool isBookmarked = false;

  Future<void> _toggleBookmark() async {
    final url = isBookmarked
        ? 'http://localhost:8000/bookmark/api/delete/${widget.bookId}'
        : 'http://localhost:8000/bookmark/api/add/${widget.bookId}';

    try {
      final response = isBookmarked
          ? await widget.request.delete(url)
          : await widget.request.post(url);

      if (response['status'] == 200 || response['status'] == 201) {
        // Assuming 200 OK or 201 Created is the success response
        setState(() {
          isBookmarked = !isBookmarked;
        });
      } else {
        // Handle the case when the server response is not successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update bookmark. Please try again.'),
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _toggleBookmark,
      child: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: isBookmarked ? Colors.black : Colors.white,
      ),
      backgroundColor: const Color(0xFF765827),
    );
  }
}
