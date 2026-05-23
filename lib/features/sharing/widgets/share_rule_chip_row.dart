import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../data/models/sharing/share_rule.dart';

class ShareRuleChipRow extends StatelessWidget {
  final List<ShareRule> rules;

  const ShareRuleChipRow({
    super.key,
    required this.rules,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: rules.map((rule) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _iconFor(rule.iconKey),
                size: 16,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 6),
              Text(
                rule.label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _iconFor(String iconKey) {
    switch (iconKey) {
      case 'nosmoke':
        return Icons.smoke_free_outlined;
      case 'nopet':
        return Icons.pets_outlined;
      case 'time':
        return Icons.access_time_outlined;
      default:
        return Icons.check_circle_outline;
    }
  }
}