import '../../theme/theme.dart';
import 'package:flutter/material.dart';
import '../widgets.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.onPressed,
    this.disabled = false,
    this.width,
    this.height = 45.0,
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;
  final bool disabled;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      width: width,
      height: height,
      backgroundColor: AppColors.secondary,
      disabledBackgroundColor: AppColors.secondary.withValues(alpha: 0.8),
      side: const BorderSide(color: AppColors.grey300, width: 2),
      onPressed: disabled ? null : onPressed,
      child: child,
    );
  }
}
