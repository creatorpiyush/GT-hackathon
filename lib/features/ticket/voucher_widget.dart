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
      surfaceTintColor: voucher.used == true
          ? Colors.grey[300]
          : const Color.fromRGBO(255, 255, 255, 1),
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          SvgPicture.asset(
            voucher.type == VoucherType.discount
                ? 'assets/svg/light_blue_bow_icon.svg'
                : 'assets/svg/pink bow icon.svg',
            fit: BoxFit.fill,
            height: 200.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 80.0, top: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          voucher.title,
                          style: const TextStyle(
                              fontSize: 26.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          voucher.code,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: voucher.type == VoucherType.discount
                                  ? const Color.fromRGBO(52, 229, 255, 1)
                                  : Colors.grey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: Image.asset(
                        'assets/images/qrcode.png',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(voucher.description,
                    style: const TextStyle(fontSize: 14.0)),
                const SizedBox(height: 8.0),
                if (voucher.validUntil != null)
                  Row(
                    children: [
                      const Text('Valid until: '),
                      Text(
                          '${voucher.validUntil!.year}-${voucher.validUntil!.month}-${voucher.validUntil!.day}'),
                    ],
                  ),
                if (voucher.used == true)
                  Row(
                    children: [
                      Text(
                        voucher.usedDate != null
                            ? 'Used on: ${voucher.usedDate!.year}-${voucher.usedDate!.month}-${voucher.usedDate!.day}}'
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
