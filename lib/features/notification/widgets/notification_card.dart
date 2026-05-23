import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/notification/app_notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification item;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: item.isRead
              ? AppColors.surface
              : AppColors.secondary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NotificationIcon(type: item.type, isRead: item.isRead),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                item.isRead ? FontWeight.w700 : FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      if (!item.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.timeLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  final AppNotificationType type;
  final bool isRead;

  const _NotificationIcon({
    required this.type,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    late final IconData icon;

    switch (type) {
      case AppNotificationType.booking:
        icon = Icons.note_alt_outlined;
        break;
      case AppNotificationType.system:
        icon = Icons.info_outline;
        break;
      case AppNotificationType.sharing:
        icon = Icons.route_outlined;
        break;
      case AppNotificationType.promotion:
        icon = Icons.local_offer_outlined;
        break;
    }

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: isRead
            ? AppColors.surfaceVariant
            : AppColors.secondary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: AppColors.primary),
    );
  }
}
