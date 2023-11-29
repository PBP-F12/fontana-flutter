import 'package:bookshelve_flutter/feature/forum/widgets/forum_card.dart';
import 'package:flutter/material.dart';

class ForumCreationPage extends StatefulWidget {
  @override
  _ForumCreationPageState createState() => _ForumCreationPageState();
}

class _ForumCreationPageState extends State<ForumCreationPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bookTopicController = TextEditingController();
  TextEditingController _discussionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Forum'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Forum Title'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _bookTopicController,
              decoration: InputDecoration(labelText: 'Book Topic'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _discussionController,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Discussion'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Validate input and create a new forum item
                if (_validateInput()) {
                  final newForumItem = ForumItem(
                    _titleController.text,
                    _bookTopicController.text,
                    _discussionController.text,
                  );

                  // Return the new forum item to the main forum page
                  Navigator.pop(context, newForumItem);
                } else {
                  // Show an error message or handle invalid input
                  _showErrorDialog();
                }
              },
              child: Text('Create Forum'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInput() {
    return _titleController.text.isNotEmpty &&
        _bookTopicController.text.isNotEmpty &&
        _discussionController.text.isNotEmpty;
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Please fill in all fields.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
