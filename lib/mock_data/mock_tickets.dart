import 'package:gt_hackathon/features/home_page/home_page.dart';
import 'package:gt_hackathon/features/ticket/voucher_widget.dart';

final List<UserTicket> mockTicketsWithSeat = [
  const UserTicket(
    ticketNumber: '9876543E',
    type: 'Round Trip',
    points: "+20",
    date: "2024-02-22",
    dayOfWeek: 'Thursday',
    origin: 'New York City',
    destination: 'Los Angeles',
    departureTime: '08:00 AM',
    arrivalTime: '11:30 AM',
    seat: '16E',
    travelClass: "Economy",
  ),
  const UserTicket(
    ticketNumber: '9876555D',
    type: 'One Way',
    points: "+10",
    date: "2024-02-22",
    dayOfWeek: 'Thursday',
    origin: 'San Francisco',
    destination: 'Chicago',
    departureTime: '10:15 AM',
    arrivalTime: '01:00 PM',
    seat: '15C',
    travelClass: "Economy",
  ),
  const UserTicket(
    ticketNumber: '9876444A',
    type: 'Round Trip',
    points: "-30",
    date: "2024-02-22",
    dayOfWeek: 'Sunday',
    origin: 'Seattle',
    destination: 'Miami',
    departureTime: '03:45 PM',
    arrivalTime: '09:15 PM',
    seat: '15A',
    travelClass: "Economy",
  ),
];

final List<Voucher> mockVouchers = [
  Voucher(
    title: 'Discount code',
    code: 'SJJFBLABFB',
    description: 'Redeemable in Uber app for 15 km distance trip',
    validUntil: DateTime(2025, 12, 3),
    type: VoucherType.discount,
  ),
  Voucher(
    title: 'Reward Voucher',
    code: '150 bonus points voucher',
    description: 'Economy Class',
    validUntil: DateTime(2025, 12, 3),
    type: VoucherType.reward,
  ),
  Voucher(
    title: 'Reward Voucher',
    code: '100 bonus points voucher',
    description: 'Economy Class',
    validUntil: DateTime(2024, 3, 26),
    type: VoucherType.reward,
    used: true,
  ),
  Voucher(
    title: 'Reward Voucher',
    code: '150 bonus points voucher',
    description: 'First Class',
    validUntil: null,
    type: VoucherType.reward,
    used: true,
    usedDate: DateTime(2024, 3, 26),
  ),
];
