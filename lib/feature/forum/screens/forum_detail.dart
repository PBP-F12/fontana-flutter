import 'package:bookshelve_flutter/feature/forum/widgets/forum_card.dart';
import 'package:flutter/material.dart';

class ForumDetailPage extends StatelessWidget {
  final ForumItem forumItem;

  const ForumDetailPage(this.forumItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Topic: ${forumItem.title}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Description: ${forumItem.description}'),
            // Add more details or components as needed
          ],
        ),
      ),
    );
  }
}
