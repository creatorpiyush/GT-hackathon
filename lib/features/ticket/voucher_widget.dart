import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Voucher {
  final String title;
  final String code;
  final String description;
  final DateTime? validUntil;
  final VoucherType type;
  final bool? used;
  final DateTime? usedDate;

  Voucher({
    required this.title,
    required this.code,
    required this.description,
    required this.validUntil,
    required this.type,
    this.used = false,
    this.usedDate,
  });
}

enum VoucherType { discount, reward }

class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  const VoucherCard({Key? key, required this.voucher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: voucher.used == true
          ? Colors.grey[300]
          : const Color.fromRGBO(255, 255, 255, 1),
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            child: SvgPicture.asset(
              'assets/svg/blue_bow_icon.svg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 80.0, top: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher.title,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(voucher.code),
                    const Spacer(),
                    if (voucher.type == VoucherType.discount)
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16.0),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(voucher.description),
                const SizedBox(height: 8.0),
                if (voucher.validUntil != null)
                  Row(
                    children: [
                      const Text('Valid until: '),
                      Text(voucher.validUntil!.toIso8601String()),
                    ],
                  ),
                if (voucher.used == true)
                  Row(
                    children: [
                      Text(
                        voucher.usedDate != null
                            ? 'Used on: ${voucher.usedDate!.toIso8601String()}'
                            : 'Used',
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
