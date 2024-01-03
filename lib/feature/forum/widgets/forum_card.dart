import 'package:bookshelve_flutter/feature/forum/models/forum.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_detail.dart';
import 'package:bookshelve_flutter/feature/forum/widgets/forum_profile.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForumCard extends StatelessWidget {
  final Forum forum;
  final int index;

  const ForumCard({super.key, required this.forum, required this.index});

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    List<Widget> forumBookWidgets = [
      ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(forum.book.cover, width: 100)),
      const SizedBox(width: 6),
      Flexible(child: Text(forum.book.title, textAlign: TextAlign.left))
    ];

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
                  child: Row(
                    mainAxisAlignment: index.isEven
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: index.isEven
                        ? forumBookWidgets
                        : forumBookWidgets.reversed.toList(),
                  ),
                ),
                const SizedBox(height: 0),
                SizedBox(
                  width: 300,
                  child: Card(
                    color: const Color(0xfff8ede3),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ForumProfile(
                              username: forum.creatorUsername,
                              userId: forum.creatorId,
                              request: request),
                          Text(forum.forumTitle,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily:
                                      GoogleFonts.dmSerifDisplay().fontFamily,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                          // Text(forum.forumTitle),
                        ],
                      ),
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
