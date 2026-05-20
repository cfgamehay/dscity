import '../constants/app_strings.dart';
import '../extensions/extensions.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';
import 'widgets.dart';
import 'package:flutter/material.dart';

class BaseSuccessModal extends StatelessWidget {
  const BaseSuccessModal({
    super.key,
    required this.title,
    this.subTitle,
    required this.onConfirm,
  });

  final String title;
  final String? subTitle;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 30, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              size: 60,
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.customTextStyle(
                fontSize: 18,
                fontWeightName: FontWeightName.bold,
                // color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (subTitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subTitle!,
                style: AppTextStyles.regular,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.5,
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm.call();
                  },
                  child: Text(
                    AppStrings.btnConfirm,
                    style: AppTextStyles.buttonWhiteText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
