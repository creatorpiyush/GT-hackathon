import 'package:flutter/material.dart';
import 'package:gt_hackathon/custom_route.dart';
import 'package:gt_hackathon/features/balance/balance_page.dart';
import 'package:gt_hackathon/features/home_page/home_page.dart';
import 'package:gt_hackathon/features/profile/user_profile_page.dart';
import 'package:gt_hackathon/features/chatbot/chatbot_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MyHomePage(),
    const BalancePage(),
    const UserProfile(),
  ];

  final List<String> _appBarTitles = [
    'Home',
    'Balance',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 50.0,
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
            child: Image.asset('assets/images/Appicon.png'),
          ),
        ),
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.balance),
            label: 'Balance',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box_rounded,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
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
        autofocus: true,
        enableFeedback: true,
        child: const Icon(Icons.chat_bubble_outline_rounded),
      ),
    );
  }
}
