import 'package:gt_hackathon/features/ticket/voucher_widget.dart';

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
