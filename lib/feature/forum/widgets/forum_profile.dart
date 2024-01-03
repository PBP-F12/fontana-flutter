import 'package:bookshelve_flutter/constant/color.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';

class ForumProfile extends StatefulWidget {
  final String username;
  final int userId;
  final CookieRequest request;

  const ForumProfile(
      {super.key,
      required this.username,
      required this.userId,
      required this.request});

  @override
  State<ForumProfile> createState() =>
      _ForumProfileState(this.username, this.userId, this.request);
}

class _ForumProfileState extends State<ForumProfile> {
  final String username;
  final int userId;
  final CookieRequest request;

  late NetworkImage profileImage;

  _ForumProfileState(this.username, this.userId, this.request);

  @override
  void initState() {
    super.initState();
    profileImage = request.getProfilePictureByUserId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image:
                    DecorationImage(fit: BoxFit.cover, image: profileImage))),
        const SizedBox(width: 4),
        Text(username, style: const TextStyle(fontSize: 16))
      ],
    );
  }
}

// class ForumProfile extends StatelessWidget {
//   final String username;

//   const ForumProfile({super.key, required this.username});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Icon(Icons.person, color: FontanaColor.brown1, size: 30),
//         const SizedBox(width: 4),
//         Text(username, style: const TextStyle(fontSize: 16))
//       ],
//     );
//   }
// }
