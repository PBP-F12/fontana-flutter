import 'dart:convert';

import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumCreationPage extends StatefulWidget {
  final CookieRequest request;

  const ForumCreationPage(this.request, {super.key});

  @override
  _ForumCreationPageState createState() => _ForumCreationPageState(request);
}

class _ForumCreationPageState extends State<ForumCreationPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discussionController = TextEditingController();

  late Future<dynamic> books;

  String _bookTopicController = '';

  CookieRequest request = CookieRequest();

  _ForumCreationPageState(CookieRequest request) {
    this.request = request;
  }

  Future<dynamic> getBooks() async {
    Uri url = Uri.parse('http://127.0.0.1:8000/json/');
    final response = await http.get(url);
    final body = json.decode(response.body);

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
        title: const Text('Create Forum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Forum Title'),
            ),
            const SizedBox(height: 16.0),
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
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _discussionController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Discussion'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                // Validate input and create a new forum item
                if (_validateInput()) {
                  final response = await request.postJson(
                      'http://localhost:8000/forum/api/create',
                      jsonEncode(<String, String>{
                        'title': _titleController.text,
                        'bookTopic': _bookTopicController,
                        'discussion': _discussionController.text
                      }));

                  if (response['status'] == 200) {
                    // Return the new forum item to the main forum page
                    Navigator.pop(context);
                  }
                } else {
                  // Show an error message or handle invalid input
                  _showErrorDialog();
                }
              },
              child: const Text('Create Forum'),
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
        title: const Text('Error'),
        content: const Text('Please fill in all fields.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
