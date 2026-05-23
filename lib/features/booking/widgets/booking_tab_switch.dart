import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../provider/booking_state.dart';

class BookingTabSwitch extends StatelessWidget {
  final BookingTab activeTab;
  final ValueChanged<BookingTab> onChanged;

  const BookingTabSwitch({
    super.key,
    required this.activeTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          _BookingTabPill(
            label: 'Đang đặt',
            selected: activeTab == BookingTab.active,
            onTap: () => onChanged(BookingTab.active),
          ),
          _BookingTabPill(
            label: 'Lịch sử',
            selected: activeTab == BookingTab.history,
            onTap: () => onChanged(BookingTab.history),
          ),
          _BookingTabPill(
            label: 'Đã lưu',
            selected: activeTab == BookingTab.saved,
            onTap: () => onChanged(BookingTab.saved),
          ),
        ],
      ),
    );
  }
}

class _BookingTabPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BookingTabPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.secondary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: selected ? AppColors.onSecondary : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
