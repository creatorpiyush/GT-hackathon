import 'package:flutter/material.dart';
import 'package:gt_hackathon/features/ticket/voucher_view.dart';

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
            const SizedBox(height: 10.0),
            _value == 0 ? const TicketList() : VoucherView(),
          ],
        ),
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
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return const Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text('Code'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, size: 16.0),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text('Description'),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text('Valid until: '),
                      Text('2022-12-31T00:00:00.000Z'),
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
