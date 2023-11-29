import 'package:bookshelve_flutter/feature/forum/widgets/forum_card.dart';
import 'package:flutter/material.dart';

class ForumDetailPage extends StatefulWidget {
  final ForumItem forumItem;

  const ForumDetailPage(this.forumItem, {super.key});

  @override
  _ForumDetailPageState createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  List<String> comments = [];

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
              'Title: ${widget.forumItem.title}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Book Topic: ${widget.forumItem.bookTopic}'),
            const SizedBox(height: 8.0),
            Text('Discussion: ${widget.forumItem.discussion}'),
            const SizedBox(height: 16.0),
            const Text(
              'Comments:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildCommentList(),
            const SizedBox(height: 16.0),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(labelText: 'Add a comment'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // Add the comment to the list
                setState(() {
                  comments.add(_commentController.text);
                  _commentController.clear();
                });
              },
              child: const Text('Add Comment'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: comments.map((comment) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text('- $comment'),
        );
      }).toList(),
    );
  }
}
