import 'package:flutter/material.dart';
import 'package:gt_hackathon/custom_route.dart';
import 'package:gt_hackathon/features/login/login_page.dart';
import 'package:gt_hackathon/features/ticket/voucher_view.dart';
import 'package:gt_hackathon/mock_data/mock_tickets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  int? _value = 0;
  List<String> choices = ['Ticket', 'Voucher'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(top: 13.0, left: 13.0, right: 13.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(230, 253, 255, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 10.0,
                  children: List<Widget>.generate(
                    2,
                    (int index) {
                      return ChoiceChip(
                        label: Text(choices[index]),
                        selected: _value == index,
                        backgroundColor: const Color.fromRGBO(230, 253, 255, 1),
                        selectedColor: const Color.fromRGBO(255, 208, 223, 1),
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? index : null;
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
                IconButton(
                  tooltip: "Logout",
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    logout(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            _value == 0 ? const TicketList() : VoucherView(),
          ],
        ),
      ),
    );
  }
}

void logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  prefs.setBool("isLogin", false);
  if (context.mounted) {
    Navigator.of(context).pushReplacement(
      FadePageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}

class TicketList extends StatelessWidget {
  const TicketList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: mockTicketsWithSeat.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            surfaceTintColor: const Color.fromRGBO(255, 255, 255, 1),
            color: const Color.fromRGBO(255, 255, 255, 1),
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 20.0, top: 5.0, bottom: 5.0),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 190, 152, 1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          mockTicketsWithSeat[index].seat,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '${mockTicketsWithSeat[index].origin} - ${mockTicketsWithSeat[index].destination}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mockTicketsWithSeat[index].departureTime,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            mockTicketsWithSeat[index].date,
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mockTicketsWithSeat[index].arrivalTime,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            mockTicketsWithSeat[index].date,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // random name 10 numbers
                          Text(
                            'T ${mockTicketsWithSeat[index].ticketNumber}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Image.asset(
                          'assets/images/qrcode.png',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
