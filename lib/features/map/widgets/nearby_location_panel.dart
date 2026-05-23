import 'package:dscity_mobile_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../data/models/map/rental_location.dart';
import 'nearby_location_card.dart';

class NearbyLocationsPanel extends StatelessWidget {
  final List<RentalLocation> locations;
  final ValueChanged<RentalLocation> onLocationTap;

  const NearbyLocationsPanel({
    super.key,
    required this.locations,
    required this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Gần bạn',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: color.primary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Xem tất cả'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...locations.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: NearbyLocationCard(
                location: item,
                onTap: () => onLocationTap(item),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
