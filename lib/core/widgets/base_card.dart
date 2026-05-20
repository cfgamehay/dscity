import 'package:flutter/material.dart';
import '../theme/theme.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    super.key,
    this.child,
    this.width,
    this.backgroundColor,
    this.borderRadius,
    this.margin,
    this.padding,
    this.isShadow = true,
  });

  final Widget? child;
  final double? width;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        boxShadow: !isShadow
            ? null
            : const [
                BoxShadow(
                  color: AppColors.grey200,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
      ),
      child: child,
    );
  }
}
