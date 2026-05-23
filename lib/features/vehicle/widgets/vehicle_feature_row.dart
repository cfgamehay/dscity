import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../data/models/vehicle/vehicle_feature.dart';

class VehicleDetailFeatureRow extends StatelessWidget {
  final List<VehicleFeature> features;

  const VehicleDetailFeatureRow({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    final items = features.take(3).toList();

    return Row(
      children: items.map((feature) {
        return Expanded(
          child: Column(
            children: [
              Icon(
                _iconFor(feature.iconKey),
                size: 18,
                color: AppColors.secondary,
              ),
              const SizedBox(height: 6),
              Text(
                feature.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _iconFor(String iconKey) {
    switch (iconKey) {
      case 'insurance':
        return Icons.verified_user_outlined;
      case 'delivery':
        return Icons.local_shipping_outlined;
      case 'support':
        return Icons.support_agent_outlined;
      case 'helmet':
        return Icons.health_and_safety_outlined;
      default:
        return Icons.check_circle_outline;
    }
  }
}