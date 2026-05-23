import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../provider/parking_listing_state.dart';

class ParkingFilterChipRow extends StatelessWidget {
  final ParkingTypeFilter typeFilter;
  final bool onlyAvailable;
  final bool onlyOpen24h;
  final ValueChanged<ParkingTypeFilter> onTypeChanged;
  final VoidCallback onToggleAvailable;
  final VoidCallback onToggleOpen24h;

  const ParkingFilterChipRow({
    super.key,
    required this.typeFilter,
    required this.onlyAvailable,
    required this.onlyOpen24h,
    required this.onTypeChanged,
    required this.onToggleAvailable,
    required this.onToggleOpen24h,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'Tất cả',
            selected: typeFilter == ParkingTypeFilter.all,
            onTap: () => onTypeChanged(ParkingTypeFilter.all),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Trong nhà',
            selected: typeFilter == ParkingTypeFilter.indoor,
            onTap: () => onTypeChanged(ParkingTypeFilter.indoor),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Ngoài trời',
            selected: typeFilter == ParkingTypeFilter.outdoor,
            onTap: () => onTypeChanged(ParkingTypeFilter.outdoor),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Còn chỗ',
            selected: onlyAvailable,
            onTap: onToggleAvailable,
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Mở 24/7',
            selected: onlyOpen24h,
            onTap: onToggleOpen24h,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.secondary.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? AppColors.secondary : AppColors.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.secondary : AppColors.primary,
          ),
        ),
      ),
    );
  }
}