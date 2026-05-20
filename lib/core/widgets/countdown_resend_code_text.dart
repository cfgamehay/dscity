import 'package:dscity_mobile_app/core/constants/app_strings.dart';

import '../extensions/extensions.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownResendCodeText extends ConsumerStatefulWidget {
  const CountdownResendCodeText({super.key, required this.onResendCode});

  final VoidCallback onResendCode;

  @override
  ConsumerState<CountdownResendCodeText> createState() =>
      _CountdownResendCodeTextState();
}

class _CountdownResendCodeTextState
    extends ConsumerState<CountdownResendCodeText> {
  late CountdownTimer countdownTimer;
  String timeLeft = '00:00';
  final int totalSeconds = 120;

  ///Always show text resend code follow customer requirement
  bool isShowTextResendCode = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    countdownTimer = CountdownTimer(totalSeconds: totalSeconds);
    countdownTimer.start(
      (time) {
        setState(() {
          timeLeft = time;
        });
      },
      onFinish: () {
        setState(() {
          isShowTextResendCode = true;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              timeLeft,
              style: AppTextStyles.customTextStyle(
                fontSize: 22,
                fontWeightName: FontWeightName.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            if (isShowTextResendCode)
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.primary),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      //stop countdown
                      countdownTimer.stop();
                      //restart countdown
                      startCountdown();

                      //Call function resend code
                      widget.onResendCode();
                    });
                  },
                  child: Text(
                    AppStrings.txtResendCode,
                    style: AppTextStyles.customTextStyle(
                      fontSize: 16,
                      fontWeightName: FontWeightName.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
