import 'package:flutter/material.dart';
import 'package:gt_hackathon/custom_route.dart';
import 'package:gt_hackathon/features/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String isLogin = "";
  @override
  void initState() {
    super.initState();
    userProfileData();
  }

  Future<void> userProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getString("username") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Profile Page',
            ),
            Text(isLogin),
            IconButton(
              tooltip: "Logout",
              icon: const Icon(Icons.logout),
              onPressed: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogin", false);
  if (context.mounted) {
    Navigator.of(context).pushReplacement(
      FadePageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
