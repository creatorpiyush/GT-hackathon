import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gt_hackathon/custom_route.dart';
import 'package:gt_hackathon/features/checkin/checkin_page.dart';
import 'package:gt_hackathon/features/home_page/home_page.dart';
import 'package:gt_hackathon/features/chatbot/chatbot_page2.dart';
import 'package:gt_hackathon/features/ticket/ticket_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      dialogBuilder(context);
    });
  }

  final List<Widget> _pages = [
    const TicketBalanceScreen(),
    const ChatScreen(),
    const TicketPage(),
  ];

  final List<String> _appBarTitles = [
    'Home',
    'Assistant',
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
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              icon: SvgPicture.asset(
                'assets/svg/home_icon.svg',
              ),
            ),
            backgroundColor: const Color.fromRGBO(183, 79, 111, 1),
            activeIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/icon-home-pressed.svg',
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              icon: SvgPicture.asset(
                'assets/svg/icon_assistance.svg',
              ),
            ),
            backgroundColor: const Color.fromRGBO(183, 79, 111, 1),
            activeIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/icon-assistance-pressed-1.svg',
              ),
            ),
            label: 'Assistant',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              icon: SvgPicture.asset(
                'assets/svg/tickets-icon.svg',
              ),
            ),
            backgroundColor: const Color.fromRGBO(183, 79, 111, 1),
            activeIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/icon-tickets-pressed.svg',
              ),
            ),
            label: 'Tickets',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(183, 79, 111, 1),
        onTap: _onItemTapped,
      ),
      floatingActionButton: _appBarTitles[_selectedIndex] != 'Assistant'
          ? FloatingActionButton.extended(
              label: const Text('Check In',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  )),
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              isExtended: true,
              backgroundColor: const Color.fromRGBO(183, 79, 111, 1),
              onPressed: () {
                Navigator.of(context).push(
                  FadePageRoute(
                    builder: (context) => const CheckInPage(),
                  ),
                );
              },
              tooltip: 'ChatBot',
              autofocus: true,
              enableFeedback: true,
            )
          : const SizedBox(),
    );
  }

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Unlock your bonus!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Hi John,',
                style: TextStyle(fontSize: 16.0),
              ),
              const Text(
                'Great news! You can earn 25 bonus points for joining TicketPal! 🚀',
                softWrap: true,
                style: TextStyle(fontSize: 16.0),
              ),
              const Text(
                'To supercharge your experience:',
                softWrap: true,
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Enable Geo-Tracking',
                      softWrap: true,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all(
                      const Color.fromRGBO(183, 79, 111, 1),
                    ),
                    value: true,
                    onChanged: (value) {
                      log(value.toString());
                    },
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Enable Newsletter',
                      softWrap: true,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all(
                      const Color.fromRGBO(183, 79, 111, 1),
                    ),
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel',
                  style: TextStyle(color: Color.fromRGBO(183, 79, 111, 1))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Confirm',
                  style: TextStyle(color: Color.fromRGBO(183, 79, 111, 1))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
