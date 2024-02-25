// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:gt_hackathon/features/checkin/scanner_page.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _passengerName = "";
  String _ticketCode = "";
  String _departure = "";
  String _destination = "";
  String _train = "";
  String _seat = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Check in',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 82, 122, 1),
                  ),
                ),
                const Text(
                    'Please enter your train ticket information to check in.',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 13.0,
                    )),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Passenger Name',
                    hintText: 'Enter your name',
                    helperText: 'Mandatory',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusColor: Colors.red,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) => _passengerName = value!,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Ticket Code',
                    hintText: 'Enter your ticket code',
                    helperText: 'Mandatory',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your ticket code';
                    }
                    return null;
                  },
                  onSaved: (value) => _ticketCode = value!,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Departure',
                    hintText: 'Enter your departure station',
                    helperText: 'Mandatory',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your departure station';
                    }
                    return null;
                  },
                  onSaved: (value) => _departure = value!,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Destination',
                    hintText: 'Enter your destination station',
                    helperText: 'Mandatory',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your destination station';
                    }
                    return null;
                  },
                  onSaved: (value) => _destination = value!,
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Train',
                          hintText: 'Enter the train name (optional)',
                          helperText: 'Optional',
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        onSaved: (value) => _train = value!,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Seat',
                          hintText: 'Enter your seat number (optional)',
                          helperText: 'Optional',
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        onSaved: (value) => _seat = value!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200.0, 40.0),
                        backgroundColor: const Color.fromRGBO(204, 204, 204, 1),
                        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        textStyle: const TextStyle(fontSize: 16.0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Check In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Scan',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            )),
        icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
        backgroundColor: const Color.fromRGBO(183, 79, 111, 1),
        isExtended: true,
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CameraScannerPage(),
          ));
        },
      ),
    );
  }
}
