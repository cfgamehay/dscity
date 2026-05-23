import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../provider/parking_listing_state.dart';

class ParkingSortSelector extends StatelessWidget {
  final ParkingSortType currentSort;
  final bool canSortByNearest;
  final ValueChanged<ParkingSortType> onChanged;

  const ParkingSortSelector({
    super.key,
    required this.currentSort,
    required this.canSortByNearest,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Sắp xếp',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ParkingSortType>(
              value: currentSort,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: [
                DropdownMenuItem(
                  value: ParkingSortType.nearest,
                  enabled: canSortByNearest,
                  child: Text(
                    'Gần nhất',
                    style: TextStyle(
                      color: canSortByNearest
                          ? AppColors.primary
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                const DropdownMenuItem(
                  value: ParkingSortType.cheapest,
                  child: Text('Rẻ nhất'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
