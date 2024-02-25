import 'package:gt_hackathon/features/home_page/home_page.dart';

List<UserTicket> mockUserTickets = const [
  UserTicket(
    type: "Round Trip",
    points: 20,
    date: "2024-02-22",
    dayOfWeek: "Thursday",
    origin: "New York City",
    destination: "Los Angeles",
    departureTime: "08:00 AM",
    arrivalTime: "11:30 AM",
  ),
  UserTicket(
    type: "One Way",
    points: 15,
    date: "2024-02-15",
    dayOfWeek: "Thursday",
    origin: "San Francisco",
    destination: "Chicago",
    departureTime: "10:15 AM",
    arrivalTime: "01:00 PM",
  ),
  UserTicket(
    type: "Round Trip",
    points: 30,
    date: "2024-01-28",
    dayOfWeek: "Sunday",
    origin: "Seattle",
    destination: "Miami",
    departureTime: "03:45 PM",
    arrivalTime: "09:15 PM",
  ),
];
