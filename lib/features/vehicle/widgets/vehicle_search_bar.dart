import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class VehicleSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const VehicleSearchBar({
    super.key,
    required this.hintText,
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
              decoration: InputDecoration(
                hintText: hintText,
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
