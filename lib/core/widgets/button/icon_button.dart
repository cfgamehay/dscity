import 'package:dscity_mobile_app/core/theme/app_colors.dart';
import 'package:dscity_mobile_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback? onTap;

  final double size;
  final double iconSize;
  final bool isCircle;
  final bool elevated;

  final Color? iconColor;
  final Color? backgroundColor;

  final String? label;
  final TextStyle? labelStyle;
  final double labelSpacing;
  final int? labelMaxLines;

  const AppIconButton({
    super.key,
    this.icon,
    this.iconWidget,
    required this.onTap,
    this.size = 48,
    this.iconSize = 22,
    this.isCircle = true,
    this.elevated = false,
    this.iconColor,
    this.backgroundColor,
    this.label,
    this.labelStyle,
    this.labelSpacing = 8,
    this.labelMaxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = isCircle
        ? BorderRadius.circular(size / 2)
        : BorderRadius.circular(12);

    final Widget iconChild;
    if (iconWidget != null) {
      iconChild = SizedBox(
        width: iconSize,
        height: iconSize,
        child: iconWidget!,
      );
    } else if (icon != null) {
      iconChild = Icon(
        icon,
        size: iconSize,
        color: iconColor ?? AppColors.primary,
      );
    } else {
      iconChild = Icon(
        Icons.image_not_supported_outlined,
        size: iconSize,
        color: iconColor ?? AppColors.outline,
      );
    }

    final button = Material(
      color: backgroundColor ??
          (elevated ? AppColors.surface : Colors.transparent),
      elevation: elevated ? 6 : 0,
      shadowColor: Colors.black.withValues(alpha: .15),
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: SizedBox(
          height: size,
          width: size,
          child: Center(child: iconChild),
        ),
      ),
    );

    if (label == null || label!.trim().isEmpty) return button;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button,
        SizedBox(height: labelSpacing),
        SizedBox(
          width: double.infinity,
          child: Text(
            label!,
            style: labelStyle ?? AppTextStyles.labelMedium,
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: labelMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}