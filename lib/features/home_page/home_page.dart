import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../mock_data/mock_user_tickets_rewards.dart';

class TicketBalanceScreen extends StatefulWidget {
  const TicketBalanceScreen({Key? key}) : super(key: key);

  @override
  State<TicketBalanceScreen> createState() => _TicketBalanceScreenState();
}

class _TicketBalanceScreenState extends State<TicketBalanceScreen> {
  final List<UserTicket> tickets = mockUserTickets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello, John!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 82, 122, 1),
                  ),
                ),
                Text(
                  'Take a look at your points balance',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(235, 253, 255, 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                        child: LinearProgressIndicator(
                          value: 0.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                          backgroundColor: Colors.red,
                          minHeight: 10.0,
                          semanticsValue: '20%',
                          semanticsLabel: '20%',
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: '20',
                          style: TextStyle(
                              fontSize: 96.0,
                              color: Color.fromRGBO(0, 77, 115, 1),
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: ' points',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(0, 77, 115, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(230, 253, 255, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ticket Balance',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        return TicketCard(ticket: tickets[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final UserTicket ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ticket.travelClass,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: const Color(0xff333333),
                                  ),
                            ),
                            Text('T ${random.nextInt(1000000000).toString()}')
                          ],
                        ),
                        Text(
                          '${ticket.date} (${ticket.dayOfWeek})',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ticket.origin,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ticket.departureTime,
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ticket.destination,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ticket.arrivalTime,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          radius: 25.0,
          backgroundColor: ticket.points.contains('-')
              ? const Color.fromRGBO(204, 204, 204, 1)
              : const Color.fromRGBO(0, 234, 255, 1),
          child: Text(
            ticket.points,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: const Color.fromRGBO(0, 77, 115, 1), fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}

class UserTicket {
  final String type;
  final String points;
  final String date;
  final String dayOfWeek;
  final String origin;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final String seat;
  final String travelClass;

  const UserTicket({
    required this.type,
    required this.points,
    required this.date,
    required this.dayOfWeek,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    this.seat = '',
    this.travelClass = '',
  });
}
