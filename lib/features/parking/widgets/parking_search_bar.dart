import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class ParkingSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const ParkingSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Tìm bãi đỗ, địa điểm...',
                border: InputBorder.none,
                isCollapsed: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
              ),
            ),
          ),
        ],
      ),
    );
  }
}