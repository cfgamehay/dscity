import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import 'parking_meta_chip.dart';

class ParkingPaymentSection extends StatelessWidget {
  final String label;
  final List<String> methods;

  const ParkingPaymentSection({
    super.key,
    required this.label,
    required this.methods,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < methods.length; i++) ...[
                    ParkingMetaChip(label: methods[i]),
                    if (i < methods.length - 1) const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}