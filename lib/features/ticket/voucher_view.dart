import 'package:flutter/material.dart';
import 'package:gt_hackathon/features/ticket/voucher_widget.dart';
import 'package:gt_hackathon/mock_data/mock_tickets.dart';

class VoucherView extends StatelessWidget {
  VoucherView({Key? key}) : super(key: key);

  final List<Voucher> vouchers = mockVouchers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          return VoucherCard(voucher: voucher);
        },
      ),
    );
  }
}
