import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../provider/notification_state.dart';

class NotificationTabSwitch extends StatelessWidget {
  final NotificationTab activeTab;
  final ValueChanged<NotificationTab> onChanged;

  const NotificationTabSwitch({
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
          _TabPill(
            label: 'Tất cả',
            selected: activeTab == NotificationTab.all,
            onTap: () => onChanged(NotificationTab.all),
          ),
          _TabPill(
            label: 'Chưa đọc',
            selected: activeTab == NotificationTab.unread,
            onTap: () => onChanged(NotificationTab.unread),
          ),
        ],
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabPill({
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
          padding: const EdgeInsets.symmetric(vertical: 11),
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
