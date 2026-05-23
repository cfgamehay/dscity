import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/models/parking/parking_feature.dart';

class ParkingFeatureChipRow extends StatelessWidget {
  final List<ParkingFeature> features;

  const ParkingFeatureChipRow({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < features.length; i++) ...[
            _FeatureChip(feature: features[i]),
            if (i < features.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final ParkingFeature feature;

  const _FeatureChip({
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _iconFor(feature.iconKey),
            size: 16,
            color: AppColors.secondary,
          ),
          const SizedBox(width: 6),
          Text(
            feature.label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String iconKey) {
    switch (iconKey) {
      case 'camera':
        return Icons.videocam_outlined;
      case 'security':
        return Icons.verified_user_outlined;
      case 'fast':
        return Icons.flash_on_outlined;
      case 'roof':
        return Icons.umbrella_outlined;
      default:
        return Icons.check_circle_outline;
    }
  }
}