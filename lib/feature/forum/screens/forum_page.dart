import 'package:bookshelve_flutter/feature/forum/models/forum.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_create_form.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_detail.dart';
import 'package:bookshelve_flutter/feature/forum/widgets/forum_card.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';

class ForumMainPage extends StatefulWidget {
  final CookieRequest request;

  const ForumMainPage({super.key, required this.request});

  @override
  _ForumMainPageState createState() => _ForumMainPageState(request: request);
}

class _ForumMainPageState extends State<ForumMainPage> {
  late Future<List<Forum>> forums;

  CookieRequest request;

  _ForumMainPageState({required this.request});

  @override
  void initState() {
    super.initState();
    forums = request.getForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc8ae7d),
      body: FutureBuilder(
          future: forums,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(child: Text('error'));
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('no data'));
              }

              List<Forum> forums = snapshot.data!;

              // return Text('success');

              return ListView.builder(
                itemCount: forums.length,
                itemBuilder: (context, index) {
                  return ForumCard(forum: forums[index], index: index);
                },
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
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the forum creation page and wait for the result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForumCreationPage(request),
            ),
          );

          // If the result is not null (user created a forum), add it to the list
          if (result != null) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
