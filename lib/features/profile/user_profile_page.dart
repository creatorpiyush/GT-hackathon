import 'package:flutter/material.dart';
import 'package:gt_hackathon/custom_route.dart';
import 'package:gt_hackathon/features/chatbot/chatbot_page.dart';
import 'package:gt_hackathon/features/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Profile Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Profile Page',
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            FadePageRoute(
              builder: (context) => const ChatBotPage(),
            ),
          );
        },
        tooltip: 'ChatBot',
        child: const Icon(Icons.chat_bubble_outline_rounded),
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
