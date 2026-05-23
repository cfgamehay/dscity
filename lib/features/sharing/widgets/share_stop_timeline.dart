import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../data/models/sharing/share_stop_point.dart';

class ShareStopTimeline extends StatelessWidget {
  final List<ShareStopPoint> stopPoints;

  const ShareStopTimeline({
    super.key,
    required this.stopPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          for (int i = 0; i < stopPoints.length; i++)
            _StopItem(
              point: stopPoints[i],
              isLast: i == stopPoints.length - 1,
            ),
        ],
      ),
    );
  }
}

class _StopItem extends StatelessWidget {
  final ShareStopPoint point;
  final bool isLast;

  const _StopItem({
    required this.point,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final color = point.isPickup ? AppColors.secondary : AppColors.red;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              point.isPickup
                  ? Icons.radio_button_checked
                  : Icons.location_on,
              size: 20,
              color: color,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: AppColors.outlineVariant,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  point.title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  point.subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}