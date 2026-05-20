import 'package:dscity_mobile_app/core/constants/app_strings.dart';
import 'package:flutter/widgets.dart';
import '../theme/theme.dart';
import 'widgets.dart';

class BaseConfirmModal extends StatelessWidget {
  const BaseConfirmModal({
    super.key,
    required this.title,
    required this.onConfirm,
    this.buttonConfirmColor,
  });

  final String title;
  final VoidCallback onConfirm;
  final Color? buttonConfirmColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyles.customTextStyle(
              fontSize: 18,
              fontWeightName: FontWeightName.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SecondaryButton(
                  height: 45,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.btnNo,
                    style: AppTextStyles.buttonGreyText,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: _buildBottonConfirm(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottonConfirm(BuildContext context) {
    if (buttonConfirmColor == null) {
      return PrimaryButton(
        height: 45,
        onPressed: () {
          Navigator.pop(context);
          onConfirm.call();
        },
        child: Text(AppStrings.btnYes, style: AppTextStyles.buttonWhiteText),
      );
    }
    // buttonConfirmColor != null
    return BaseButton(
      backgroundColor: buttonConfirmColor,
      height: 45,
      onPressed: () {
        Navigator.pop(context);
        onConfirm.call();
      },
      child: Text(AppStrings.btnYes, style: AppTextStyles.buttonWhiteText),
    );
  }
}
