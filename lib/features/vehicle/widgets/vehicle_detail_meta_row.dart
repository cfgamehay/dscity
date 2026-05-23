import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class VehicleDetailMetaRow extends StatelessWidget {
  final String transmissionLabel;
  final String specLabel;
  final String fuelLabel;
  final double rating;
  final int reviewCount;

  const VehicleDetailMetaRow({
    super.key,
    required this.transmissionLabel,
    required this.specLabel,
    required this.fuelLabel,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 12,
      color: AppColors.onSurfaceVariant,
      fontWeight: FontWeight.w500,
    );

    return Row(
      children: [
        Text(transmissionLabel, style: textStyle),
        _dot(),
        Text(specLabel, style: textStyle),
        _dot(),
        Text(fuelLabel, style: textStyle),
        const Spacer(),
        const Icon(Icons.star, size: 16, color: AppColors.warning),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($reviewCount)',
          style: textStyle,
        ),
      ],
    );
  }

  Widget _dot() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: AppColors.outline,
        shape: BoxShape.circle,
      ),
    );
  }
}