import '../../theme/theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.disabled = false,
    this.width,
    this.height = 45.0,
    required this.child,
    this.borderRadius,
  });

  final void Function()? onPressed;
  final Widget child;
  final bool disabled;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    // return BaseButton(
    //   width: width,
    //   height: height,
    //   backgroundColor: AppColors.primaryColor,
    //   disabledBackgroundColor: AppColors.primaryDisabledColor,
    //   onPressed: disabled ? null : onPressed,
    //   child: child,
    // );;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        gradient: onPressed != null
            ? LinearGradient(
                // colors: [AppColors.primaryColor400, AppColors.primaryColor800],
                colors: [
                  AppColors.primary.withValues(alpha: 0.8),
                  AppColors.primary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              )
            : LinearGradient(
                // colors: [AppColors.primaryColor100, AppColors.primaryColor300],
                colors: [
                  AppColors.primary.withValues(alpha: 0.5),
                  AppColors.primary.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(25),
          ),
        ),
        onPressed: disabled ? null : onPressed,
        child: child,
      ),
    );
  }
}
