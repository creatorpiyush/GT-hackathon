import 'package:flutter/material.dart';
import 'package:gt_hackathon/custom_route.dart';
import 'package:gt_hackathon/features/home_page/home_page.dart';
import 'package:gt_hackathon/features/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      navigateToLoginOrHomePage();
    });
  }

  Future<void> navigateToLoginOrHomePage() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLogin = prefs.getBool("isLogin") ?? false;

    if (isLogin) {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          FadePageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
      }
    } else {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          FadePageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: const Center(
          child: Text(
            'Splash Screen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
