import 'package:bookshelve_flutter/feature/forum/models/forum.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_detail.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumCard extends StatelessWidget {
  final Forum forum;
  final int index;

  const ForumCard({super.key, required this.forum, required this.index});

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return Align(
      alignment: index.isEven ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(minWidth: 300, maxWidth: 300),
        child: GestureDetector(
          onTap: () {
            // Navigate to the forum detail page when a card is pressed
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForumDetailPage(request, forum.forumId),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: index.isEven
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(forum.book.cover, width: 100)),
                ),
                const SizedBox(height: 0),
                SizedBox(
                  width: 300,
                  child: Card(
                    color: Colors.redAccent,
                    child: Column(
                      children: [
                        Text(forum.forumTitle),
                        Text(forum.book.title),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
