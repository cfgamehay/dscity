import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'package:pinput/pinput.dart';

class PinPut extends StatefulWidget {
  const PinPut({
    super.key,
    this.pinController,
    this.focusNode,
    this.onChanged,
    this.onCompleted,
    this.forceErrorState = false,
  });

  final TextEditingController? pinController;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool forceErrorState;

  @override
  State<PinPut> createState() => _PinPutState();
}

class _PinPutState extends State<PinPut> {
  // late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    if (widget.pinController != null) {
      pinController = widget.pinController!;
    } else {
      pinController = TextEditingController();
    }
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode();
    }

    /// In case you need an SMS autofill feature
    // smsRetriever = SmsRetrieverImpl(SmartAuth());
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.grey500;
    const errorBorderColor = AppColors.red;

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: AppTextStyles.customTextStyle(
        fontSize: 16,
        fontWeightName: FontWeightName.bold,
        color: AppColors.black,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: focusedBorderColor)),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              keyboardType: TextInputType.number,
              length: 6,
              autofocus: true,
              //If true [errorPinTheme] will be applied
              forceErrorState: widget.forceErrorState,
              //SmsRetriever exposes methods to listen for incoming SMS
              //and extract code from it Recommended
              // smsRetriever: smsRetriever,
              controller: pinController,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              // validator: (value) {
              //   return value == '123456' ? null : 'Pin is incorrect';
              // },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: widget.onCompleted,
              onChanged: widget.onChanged,
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // margin: const EdgeInsets.only(bottom: 8),
                    width: 2,
                    height: 22,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyBorderWith(
                border: const Border(
                  bottom: BorderSide(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyBorderWith(
                border: const Border(
                  bottom: BorderSide(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyWith(
                textStyle: AppTextStyles.customTextStyle(
                  fontSize: 16,
                  fontWeightName: FontWeightName.bold,
                  color: AppColors.red,
                ),
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: const Border(
                    bottom: BorderSide(color: errorBorderColor),
                  ),
                ),
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     focusNode.unfocus();
          //     formKey.currentState!.validate();
          //   },
          //   child: const Text('Validate'),
          // ),
        ],
      ),
    );
  }
}

/// You, as a developer should implement this interface.
/// You can use any package to retrieve the SMS code. in this example we are using SmartAuth
// class SmsRetrieverImpl implements SmsRetriever {
//   const SmsRetrieverImpl(this.smartAuth);

//   final SmartAuth smartAuth;

//   @override
//   Future<void> dispose() {
//     return smartAuth.removeSmsListener();
//   }

//   @override
//   Future<String?> getSmsCode() async {
//     final signature = await smartAuth.getAppSignature();
//     debugPrint('App Signature: $signature');
//     final res = await smartAuth.getSmsCode(useUserConsentApi: true);
//     if (res.succeed && res.codeFound) {
//       return res.code!;
//     }
//     return null;
//   }

//   @override
//   bool get listenForMultipleSms => false;
// }
