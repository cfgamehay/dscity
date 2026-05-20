import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../assets/assets.dart';
import '../theme/theme.dart';

class ModalHeader extends StatelessWidget {
  const ModalHeader({super.key, this.onClose, this.isEnableIconClose = true});

  final VoidCallback? onClose;
  final bool isEnableIconClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (isEnableIconClose)
            Positioned(
              top: 4,
              right: 9,
              child: GestureDetector(
                onTap: onClose,
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(
                    ImagesResource.svgIcClose,
                    colorFilter: const ColorFilter.mode(
                      AppColors.grey600,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
