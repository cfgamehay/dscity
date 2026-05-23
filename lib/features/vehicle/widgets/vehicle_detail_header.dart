import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class VehicleDetailHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onAction;
  final IconData actionIcon;

  const VehicleDetailHeader({
    super.key,
    required this.onBack,
    required this.onAction,
    this.actionIcon = Icons.favorite_border,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          _CircleIconButton(
            icon: Icons.arrow_back_ios_new,
            onTap: onBack,
            iconSize: 18,
          ),
          const Spacer(),
          _CircleIconButton(
            icon: actionIcon,
            onTap: onAction,
            iconSize: 22,
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double iconSize;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}