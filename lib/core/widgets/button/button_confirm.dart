import 'package:flutter/material.dart';
import '../../constants/app_strings.dart';
import '../../theme/theme.dart';
import '../widgets.dart';

class ButtonConfirm extends StatelessWidget {
  const ButtonConfirm({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: PrimaryButton(
            height: 45,
            onPressed: onPressed == null
                ? null
                : () {
                    onPressed?.call();
                    Navigator.pop(context);
                  },
            child: Text(
              AppStrings.btnConfirm,
              style: AppTextStyles.buttonWhiteText,
            ),
          ),
        ),
      ],
    );
  }
}
