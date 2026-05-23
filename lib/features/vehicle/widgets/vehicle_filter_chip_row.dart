import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class VehicleFilterChipRow extends StatelessWidget {
  final bool onlyAvailable;
  final VoidCallback onToggleAvailable;

  const VehicleFilterChipRow({
    super.key,
    required this.onlyAvailable,
    required this.onToggleAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _FilterChip(
            label: 'Còn xe',
            selected: onlyAvailable,
            onTap: onToggleAvailable,
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
