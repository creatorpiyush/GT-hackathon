import 'package:flutter/material.dart';
import 'package:gt_hackathon/custom_route.dart';
import 'package:gt_hackathon/features/chatbot/chatbot_page.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Balance Page"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Balance Page',
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
