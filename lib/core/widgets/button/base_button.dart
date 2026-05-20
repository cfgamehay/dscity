import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.child,
    this.onPressed,
    this.disabled = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.side,
    this.borderRadius,
  });

  final void Function()? onPressed;
  final Widget child;
  final bool disabled;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final BorderSide? side;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          disabledBackgroundColor:
              disabledBackgroundColor ?? AppColors.grey400,
          side: side,
          shadowColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        ),
        onPressed: disabled ? null : onPressed,
        child: child,
      ),
    );
  }
}
