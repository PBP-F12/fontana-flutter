import 'package:bookshelve_flutter/constant/color.dart';
import 'package:bookshelve_flutter/feature/auth/screens/login.dart';
import 'package:bookshelve_flutter/feature/onboarding/widgets/custom_text_button.dart';
import 'package:bookshelve_flutter/feature/profile/models/profile.dart';
import 'package:bookshelve_flutter/feature/profile/screens/edit_profile_page.dart';
import 'package:bookshelve_flutter/feature/profile/utils/upload_profile_image.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:bookshelve_flutter/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class DashboardPage extends StatefulWidget {
  final CookieRequest request;

  const DashboardPage({super.key, required this.request});

  @override
  State<DashboardPage> createState() => _DashboardPageState(request: request);
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Profile> profile;
  late NetworkImage profileImage;

  final CookieRequest request;

  _DashboardPageState({required this.request});

  @override
  void initState() {
    super.initState();
    profile = request.getProfileData();
    profileImage = request.getProfilePicture();
  }

  Future<void> _onRefresh() async {
    profileImage = request.getProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FontanaColor.creamy2,
      body: LiquidPullToRefresh(
        height: 200,
        color: FontanaColor.creamy0,
        backgroundColor: FontanaColor.creamy2,
        onRefresh: _onRefresh,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Center(
                child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: profileImage))),
              ),
              const SizedBox(height: 12),
              FutureBuilder(
                future: profile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: Text('error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('no data'));
                    }

                    Profile profile = snapshot.data!;

                    return Column(
                      children: [
                        Text(profile.fullName,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: FontanaColor.black,
                                fontSize: 20,
                                fontFamily:
                                    GoogleFonts.dmSerifDisplay().fontFamily)),
                        const SizedBox(height: 4),
                        Text(profile.username,
                            style: TextStyle(
                                color: FontanaColor.brown1, fontSize: 18)),
                        const SizedBox(height: 4),
                        Text(
                          profile.role,
                          style: TextStyle(
                              fontSize: 16, color: FontanaColor.brown2),
                        )
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('failed to fetch'),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),
              CustomTextButton(
                  buttonText: 'Edit Profile Picture',
                  onPressed: () async {
                    try {
                      bool isSuccessUploading = await pickImage(request);

                      if (isSuccessUploading) {
                        showToast(context, 'Success upload photo!');
                      } else {
                        showToast(context, 'Failed to upload :(');
                      }

                      setState(() {
                        profileImage = request.getProfilePicture();
                      });
                    } on Exception catch (e) {
                      print('here');
                      showToast(context,
                          'Edit profile picture only works in android :(');
                    }
                  }),
              const SizedBox(height: 12),
              CustomTextButton(
                  buttonText: 'Logout',
                  onPressed: () async {
                    final response = await request.logout();

                    if (response['status'] == 200) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    } else {
                      // TODO handle error logout
                    }
                  })
            ]),
          ),
        ]),
      ),
    );
  }
}
