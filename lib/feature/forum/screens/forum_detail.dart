import 'package:bookshelve_flutter/feature/forum/widgets/forum_card.dart';
import 'package:flutter/material.dart';

class ForumDetailPage extends StatelessWidget {
  final ForumItem forumItem;

  ForumDetailPage(this.forumItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum Detail Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${forumItem.title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Book Topic: ${forumItem.bookTopic}'),
            SizedBox(height: 8.0),
            Text('Discussion: ${forumItem.discussion}'),
            // Add more details or components as needed
          ],
        ),
      ),
    );
  }
}
