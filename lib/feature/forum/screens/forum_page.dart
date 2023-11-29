import 'package:bookshelve_flutter/feature/forum/screens/forum_detail.dart';
import 'package:bookshelve_flutter/feature/forum/widgets/forum_card.dart';
import 'package:flutter/material.dart';

class ForumMainPage extends StatelessWidget {
  final List<ForumItem> forumItems = [
    ForumItem('Topic 1', 'Description for Topic 1'),
    ForumItem('Topic 2', 'Description for Topic 2'),
    ForumItem('Topic 3', 'Description for Topic 3'),
    // Add more forum items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum Main Page'),
      ),
      body: ListView.builder(
        itemCount: forumItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(forumItems[index].title),
              subtitle: Text(forumItems[index].description),
              onTap: () {
                // Navigate to the forum detail page when a card is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForumDetailPage(forumItems[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
