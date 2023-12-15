import 'dart:convert';

import 'package:bookshelve_flutter/feature/event/models/book.dart';
import 'package:bookshelve_flutter/feature/forum/widgets/forum_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumCreationPage extends StatefulWidget {
  @override
  _ForumCreationPageState createState() => _ForumCreationPageState();
}

class _ForumCreationPageState extends State<ForumCreationPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _discussionController = TextEditingController();

  late Future<dynamic> books;

  String _bookTopicController = '';

  Future<dynamic> getBooks() async {
    Uri url = Uri.parse('http://127.0.0.1:8000/json/');
    final response = await http.get(url);
    final body = json.decode(response.body);

    print(body[0]['fields']);

    return body;
  }

  @override
  void initState() {
    super.initState();
    books = getBooks();
  }

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
            FutureBuilder(
                future: books,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(
                          'Connection done but got error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return const Text('Connection done but no data.');
                    }

                    List<dynamic> books = snapshot.data;

                    return DropdownButton<String>(
                        isExpanded: true,
                        value: _bookTopicController,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _bookTopicController = value;
                            });
                          }
                        },
                        items: [
                          const DropdownMenuItem(
                            value: '',
                            child: Text('-'),
                          ),
                          ...books
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                                value: value['pk'],
                                child: Text(value['fields']['book_title']));
                          }).toList()
                        ]);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Text('Loading...');
                  } else {
                    return const Text('error');
                  }
                }),
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
                  // Return the new forum item to the main forum page
                  Navigator.pop(context);
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
        _bookTopicController.isNotEmpty &&
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
