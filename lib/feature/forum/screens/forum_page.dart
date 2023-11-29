import 'package:bookshelve_flutter/feature/forum/screens/forum_create_form.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_detail.dart';
import 'package:bookshelve_flutter/feature/forum/widgets/forum_card.dart';
import 'package:flutter/material.dart';

class ForumMainPage extends StatefulWidget {
  @override
  _ForumMainPageState createState() => _ForumMainPageState();
}

class _ForumMainPageState extends State<ForumMainPage> {
  List<ForumItem> forumItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum Main Page'),
      ),
      body: ListView.builder(
        itemCount: forumItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(forumItems[index].title),
              subtitle: Text(forumItems[index].bookTopic),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the forum creation page and wait for the result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForumCreationPage(),
            ),
          );

          // If the result is not null (user created a forum), add it to the list
          if (result != null) {
            setState(() {
              forumItems.add(result);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
