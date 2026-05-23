import 'package:flutter/material.dart';

import '../../../core/constants/enum.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/map/rental_location.dart';

class NearbyLocationCard extends StatelessWidget {
  final RentalLocation location;
  final VoidCallback? onTap;

  const NearbyLocationCard({
    super.key,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.outline.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color.primary,
              child: Icon(
                _iconFor(location.type),
                color: color.onPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: color.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${location.distanceText} • ${location.statusText}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              location.priceText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(MapFilterType type) {
    switch (type) {
      case MapFilterType.parking:
        return Icons.local_parking;
      case MapFilterType.car:
        return Icons.directions_car;
      case MapFilterType.motorbike:
        return Icons.two_wheeler;
      case MapFilterType.sharing:
        return Icons.hub_outlined;
    }
  }
}
