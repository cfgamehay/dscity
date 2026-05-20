import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/theme/theme.dart';

class BaseErrorMessage extends StatelessWidget {
  const BaseErrorMessage({super.key, this.errorMessage = ''});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      sizeCurve: Curves.linear,
      firstChild: const SizedBox.shrink(key: ValueKey(1)),
      secondChild: Padding(
        key: const ValueKey(2),
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              ImagesResource.svgIcExclude,
              height: 15,
              width: 15,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                errorMessage,
                style: AppTextStyles.customTextStyle(
                  fontSize: 14,
                  fontWeightName: FontWeightName.regular,
                  color: AppColors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      crossFadeState:
          errorMessage.isEmpty
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
    );

    //Option 2
    // return AnimatedSwitcher(
    //   duration: const Duration(milliseconds: 300),
    //   child: errorMessage == null || errorMessage!.isEmpty
    //       ? const SizedBox.shrink(key: ValueKey(1))
    //       : Padding(
    //           key: const ValueKey(2),
    //           padding: const EdgeInsets.only(top: 8.0),
    //           child: Row(
    //             children: [
    //               SvgPicture.asset(
    //                 ImagesResource.svgIcExclude,
    //                 height: 15,
    //                 width: 15,
    //               ),
    //               SizedBox(
    //                 width: 8.w,
    //               ),
    //               Expanded(
    //                 child: Text(
    //                   errorMessage!,
    //                   style: AppTextStyles.customTextStyle(
    //                     fontSize: 14,
    //                     fontWeightName: FontWeightName.regular,
    //                     color: AppColors.red,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    // );
  }
}
