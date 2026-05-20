import 'package:flutter/widgets.dart';
import '../constants/constants.dart';

class ValidateUtils {
  ValidateUtils._();

  static final RegExp _emailRegExp = RegExp(
    // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    r'^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final RegExp _phoneRegExp = RegExp(r'^\d{9,15}$');

  static String validateEmail({
    required BuildContext context,
    required String value,
  }) {
    if (value.isEmpty) {
      return AppStrings.emailRequired;
    } else if (!_emailRegExp.hasMatch(value)) {
      return AppStrings.invalidEmail;
    }
    return '';
  }

  static String validatePassword({
    required BuildContext context,
    required String value,
  }) {
    if (value.isEmpty) {
      return AppStrings.passwordRequired;
    } else if (value.isEmpty) {
      return AppStrings.invalidPassword;
    }
    return '';
  }

  static String validateConfirmPassword({
    required BuildContext context,
    required String newPassword,
    required String oldPassword,
  }) {
    if (newPassword.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    } else if (newPassword != oldPassword) {
      return AppStrings.invalidConfirmPassword;
    }
    return '';
  }

  static String validateOtp({
    required BuildContext context,
    required String value,
  }) {
    if (value.isEmpty) {
      return AppStrings.verifyCodeRequired;
    } else if (value.length < 6) {
      return AppStrings.invalidVerifyCode;
    }
    return '';
  }

  static String validatePhone({
    required BuildContext context,
    required String value,
  }) {
    if (value.isEmpty) {
      return AppStrings.phoneRequired;
    } else if (!_phoneRegExp.hasMatch(value)) {
      return AppStrings.invalidPhone;
    }
    return '';
  }

  static String validateUsername({
    required BuildContext context,
    required String value,
  }) {
    if (value.isEmpty) {
      return AppStrings.usernameRequired;
    }
    // else if (value.length < 3) {
    //   return context.loc.txtInvalidUsername;
    // }
    return '';
  }

  static String validateUserFullname({
    required BuildContext context,
    required String value
  }){
    if (value.isEmpty) {
      return AppStrings.fullnameRequired;
    }
    // chứa số

    // quá ngắn


    return '';
  }
}
