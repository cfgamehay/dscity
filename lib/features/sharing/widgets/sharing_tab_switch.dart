import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../provider/sharing_search_state.dart';

class SharingTabSwitch extends StatelessWidget {
  final SharingTab activeTab;
  final ValueChanged<SharingTab> onChanged;

  const SharingTabSwitch({
    super.key,
    required this.activeTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'Tìm chuyến',
              selected: activeTab == SharingTab.findTrip,
              onTap: () => onChanged(SharingTab.findTrip),
            ),
          ),
          Expanded(
            child: _TabButton(
              label: 'Chia sẻ xe',
              selected: activeTab == SharingTab.shareRide,
              onTap: () => onChanged(SharingTab.shareRide),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
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
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.onSecondary : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
