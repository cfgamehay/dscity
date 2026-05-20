import 'package:dscity_mobile_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../assets/assets.dart';
import '../extensions/extensions.dart';
import '../theme/theme.dart';

class EmptyWidget extends ConsumerWidget {
  const EmptyWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          //Svg Image Empty
          SvgPicture.asset(
            ImagesResource.svgFavoritesEmpty,
            width: 180,
            height: 140,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? AppStrings.txtNoData,
            style: AppTextStyles.customTextStyle(
              fontSize: 16,
              fontWeightName: FontWeightName.regular,
              color: AppColors.grey600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
