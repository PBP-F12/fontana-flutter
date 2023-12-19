import 'package:bookshelve_flutter/feature/forum/screens/forum_create_form.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_detail.dart';
import 'package:bookshelve_flutter/feature/home/widgets/custom_navigation_bar.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';

class ForumMainPage extends StatefulWidget {
  final CookieRequest request;

  const ForumMainPage(this.request, {super.key});

  @override
  _ForumMainPageState createState() => _ForumMainPageState(request);
}

class _ForumMainPageState extends State<ForumMainPage> {
  late Future<dynamic> forums;

  CookieRequest request = CookieRequest();

  _ForumMainPageState(CookieRequest request) {
    this.request = request;
  }

  Future<dynamic> getForums() async {
    final responseBody = await request.get('http://localhost:8000/forum/api');

    if (responseBody['status'] == 200) {
      return responseBody['forums'];
    } else {
      throw 'Failed';
    }
  }

  @override
  void initState() {
    super.initState();
    forums = getForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum Main Page'),
      ),
      body: FutureBuilder(
          future: forums,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(child: Text('error'));
              }

              if (!snapshot.hasData) {
                return const Center(child: Text('no data'));
              }

              List<dynamic> forums = snapshot.data;

              // return Text('success');

              return ListView.builder(
                itemCount: forums.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(forums[index]['forumTitle']),
                      subtitle: Text(forums[index]['book']['title']),
                      onTap: () {
                        // Navigate to the forum detail page when a card is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForumDetailPage(
                                request, forums[index]['forumId']),
                          ),
                        );
                      },
                    ),
                  );
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
