import 'package:flutter/material.dart';
import 'ticket.dart';

class TicketList extends StatelessWidget {
  final List<Ticket> tickets;

  const TicketList({Key? key, required this.tickets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return Card(
          child: ListTile(
            title: Text('${ticket.type} - ${ticket.ticketId}'),
            subtitle: Text(
              '${ticket.date} - ${ticket.from} to ${ticket.to}',
              style: const TextStyle(fontSize: 12.0),
            ),
            trailing: Column(
              children: [
                Text('${ticket.departureTime} - ${ticket.arrivalTime}'),
                Text('${ticket.points} points'),
              ],
            ),
          ),
        );
      },
    );
  }
}
