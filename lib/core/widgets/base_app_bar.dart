import '../assets/assets.dart';
import '../theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    super.key,
    required this.context,
    this.isLeading = true,
    this.title,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation,
    this.onPressed,
    this.actions,
    this.maxLinesTitle = 1,
  });

  final BuildContext context;
  final bool isLeading;
  final String? title;
  final bool centerTitle;
  final Color? backgroundColor;
  final double? elevation;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  final int maxLinesTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: isLeading ? 0 : null,
      title: title != null && title!.isNotEmpty
          ? Padding(
              padding: EdgeInsets.only(right: actions == null ? 16 : 0),
              child: Text(
                title!,
                style: AppTextStyles.customTextStyle(
                  fontSize: 18,
                  fontWeightName: FontWeightName.bold,
                  color: AppColors.black,
                ),
                maxLines: maxLinesTitle,
                overflow: TextOverflow.ellipsis,
              ),
            )
          : null,
      centerTitle: centerTitle,
      actions: actions,
      elevation: elevation ?? 0,
      shadowColor: Colors.white.withValues(alpha: 0.6),
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? AppColors.surface,
      leading: isLeading
          ? IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed:
                  onPressed ??
                  () {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  },
              icon: SvgPicture.asset(
                ImagesResource.svgIcBackCircle,
                height: 35,
                width: 35,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
