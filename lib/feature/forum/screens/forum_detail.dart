import 'dart:convert';

import 'package:bookshelve_flutter/constant/color.dart';
import 'package:bookshelve_flutter/constant/urls.dart';
import 'package:bookshelve_flutter/feature/onboarding/widgets/custom_text_button.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForumDetailPage extends StatefulWidget {
  final CookieRequest request;
  final String forumId;

  const ForumDetailPage(this.request, this.forumId, {super.key});

  @override
  _ForumDetailPageState createState() =>
      _ForumDetailPageState(this.request, this.forumId);
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  List<String> comments = [];

  CookieRequest request = CookieRequest();
  String forumId;

  late Future<dynamic> forumDetail;

  _ForumDetailPageState(this.request, this.forumId);

  Future<dynamic> getForumDetail() async {
    final responseBody =
        await request.get('${Urls.backendUrl}/forum/api/$forumId');

    // print(responseBody);

    if (responseBody['status'] == 200) {
      return responseBody['forum'];
    } else {
      throw 'Failed';
    }
  }

  @override
  void initState() {
    super.initState();
    forumDetail = getForumDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FontanaColor.creamy2,
        appBar: AppBar(
            title: Text('Forum Detail Page',
                style: TextStyle(
                    color: FontanaColor.creamy0,
                    fontFamily: GoogleFonts.merriweather().fontFamily)),
            backgroundColor: const Color.fromARGB(255, 132, 112, 73)),
        body: FutureBuilder(
            future: forumDetail,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(child: Text('error'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('no data'));
                }

                // return const Text('data');
                dynamic forum = snapshot.data;
                List<dynamic> replies = forum['replies'];

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title: ' + forum['forumTitle'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Book Topic: ' + forum['book']['title']),
                      const SizedBox(height: 8.0),
                      Text('Discussion: ' + forum['forumDiscussion']),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Comments:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      replies.isNotEmpty
                          ? _buildCommentList(replies)
                          : const Center(child: Text('No Comments.')),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _commentController,
                        decoration:
                            const InputDecoration(labelText: 'Add a comment'),
                      ),
                      const SizedBox(height: 8.0),
                      CustomTextButton(
                          buttonText: 'Add Comment',
                          onPressed: () async {
                            final requestBody = await request.postJson(
                                '${Urls.backendUrl}/forum/api/reply/$forumId',
                                jsonEncode(<String, String>{
                                  'comment': _commentController.text
                                }));

                            if (requestBody['status'] == 200) {
                              setState(() {
                                forumDetail = getForumDetail();
                                _commentController.clear();
                              });
                            }
                          }),
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text('failed to fetch'),
                );
              }
            })));
  }

  Widget _buildCommentList(List<dynamic> comments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: comments.map((comment) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: [
                Text(
                  comment['username'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(comment['comment']),
              ],
            ));
      }).toList(),
    );
  }
}
