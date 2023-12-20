import 'package:bookshelve_flutter/constant/color.dart';
import 'package:flutter/material.dart';

class ForumProfile extends StatelessWidget {
  final String username;

  const ForumProfile({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.person, color: FontanaColor.brown1, size: 30),
        const SizedBox(width: 4),
        Text(username, style: const TextStyle(fontSize: 16))
      ],
    );
  }
}
