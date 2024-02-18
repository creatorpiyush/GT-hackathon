import 'package:flutter/material.dart';
import 'package:gt_hackathon/features/home_page/home_page_view_login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomePageViewLogic? homePageViewLogic;

  // constants for user details
  String userName = '';
  int userId = 0;
  String userEmail = '';
  String userFirstName = '';
  String userLastName = '';
  String userPhoneNumber = '';
  String userUsername = '';
  String userProfilePicture = '';
  double userBalance = 0.0;
  List userTransactions = [];

  @override
  void initState() {
    homePageViewLogic = HomePageViewLogic();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _getUserDetails();
      });
    });
    super.initState();
  }

  Future<void> _getUserDetails() async {
    userFirstName = await homePageViewLogic?.getUserFirstName() ?? "";
    userLastName = await homePageViewLogic?.getUserLastName() ?? "";
    userPhoneNumber = await homePageViewLogic?.getUserPhoneNumber() ?? "";
    userUsername = await homePageViewLogic?.getUserUsername() ?? "";
    userProfilePicture = await homePageViewLogic?.getUserProfilePicture() ?? "";
    userBalance = await homePageViewLogic?.getUserBalance() ?? 0;
    userTransactions = await homePageViewLogic?.getUserTransactions() ?? [];
  }

  List<double> numbers = [0.5, 0.2, 0.3]; // Adjust values as needed
  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red
  ]; // Adjust colors as neede

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(230, 253, 255, 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              welcomeHeading(),
              subHeading(),
            ],
          ))
        ],
      ),
    ));
  }

  Padding subHeading() {
    return const Padding(
      padding: EdgeInsets.only(left: 22.0, right: 22.0),
      child: Text(
        'Take a look at your points balance',
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontSize: 16,
        ),
      ),
    );
  }

  Padding welcomeHeading() {
    return Padding(
      padding: const EdgeInsets.only(top: 17.0, left: 22.0),
      child: Text(
        'Welcome, $userFirstName!',
        style: const TextStyle(
          color: Color.fromRGBO(0, 77, 115, 1),
          fontSize: 24,
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rewards'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have 100 points'),
                Text('You can redeem 50 points for a free coffee'),
                Text('You can redeem 100 points for a free train ticket'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
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
