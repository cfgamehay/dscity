import 'package:flutter/material.dart';

import 'app_colors.dart';

enum FontWeightName {
  thin,
  extraLight,
  light,
  regular,
  medium,
  semiBold,
  bold,
  extraBold,
  black,
}

class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'Roboto';

  static const Map<FontWeightName, FontWeight> fontWeightValues = {
    FontWeightName.thin: FontWeight.w100,
    FontWeightName.extraLight: FontWeight.w200,
    FontWeightName.light: FontWeight.w300,
    FontWeightName.regular: FontWeight.w400,
    FontWeightName.medium: FontWeight.w500,
    FontWeightName.semiBold: FontWeight.w600,
    FontWeightName.bold: FontWeight.w700,
    FontWeightName.extraBold: FontWeight.w800,
    FontWeightName.black: FontWeight.w900,
  };

  static TextStyle customTextStyle({
    double fontSize = 16,
    double height = 1.4,
    Color color = AppColors.black,
    FontWeightName fontWeightName = FontWeightName.regular,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
    TextDecorationStyle? decorationStyle,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      height: height,
      color: color,
      fontWeight: fontWeightValues[fontWeightName],
      decoration: decoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      decorationStyle: decorationStyle,
      fontStyle: fontStyle,
    );
  }

  // New semantic styles
  static final TextStyle displayLarge = customTextStyle(
    fontSize: 36,
    height: 1.2,
    fontWeightName: FontWeightName.bold,
  );

  static final TextStyle displayMedium = customTextStyle(
    fontSize: 32,
    height: 1.2,
    fontWeightName: FontWeightName.bold,
  );

  static final TextStyle displaySmall = customTextStyle(
    fontSize: 28,
    height: 1.25,
    fontWeightName: FontWeightName.semiBold,
  );

  static final TextStyle headlineLarge = customTextStyle(
    fontSize: 24,
    height: 1.3,
    fontWeightName: FontWeightName.bold,
  );

  static final TextStyle headlineMedium = customTextStyle(
    fontSize: 22,
    height: 1.3,
    fontWeightName: FontWeightName.semiBold,
  );

  static final TextStyle headlineSmall = customTextStyle(
    fontSize: 20,
    height: 1.3,
    fontWeightName: FontWeightName.semiBold,
  );

  static final TextStyle titleLarge = customTextStyle(
    fontSize: 18,
    height: 1.35,
    fontWeightName: FontWeightName.bold,
  );

  static final TextStyle titleMedium = customTextStyle(
    fontSize: 16,
    height: 1.35,
    fontWeightName: FontWeightName.semiBold,
  );

  static final TextStyle titleSmall = customTextStyle(
    fontSize: 14,
    height: 1.35,
    fontWeightName: FontWeightName.medium,
  );

  static final TextStyle bodyLarge = customTextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeightName: FontWeightName.regular,
  );

  static final TextStyle bodyMedium = customTextStyle(
    fontSize: 14,
    height: 1.45,
    fontWeightName: FontWeightName.regular,
  );

  static final TextStyle bodySmall = customTextStyle(
    fontSize: 12,
    height: 1.4,
    fontWeightName: FontWeightName.regular,
  );

  static final TextStyle labelLarge = customTextStyle(
    fontSize: 14,
    height: 1.3,
    fontWeightName: FontWeightName.medium,
  );

  static final TextStyle labelMedium = customTextStyle(
    fontSize: 12,
    height: 1.3,
    fontWeightName: FontWeightName.medium,
  );

  static final TextStyle labelSmall = customTextStyle(
    fontSize: 10,
    height: 1.2,
    fontWeightName: FontWeightName.medium,
  );

  static final TextStyle buttonLarge = customTextStyle(
    fontSize: 16,
    height: 1.3,
    fontWeightName: FontWeightName.bold,
    color: AppColors.white,
  );

  static final TextStyle buttonMedium = customTextStyle(
    fontSize: 14,
    height: 1.3,
    fontWeightName: FontWeightName.semiBold,
    color: AppColors.white,
  );

  static final TextStyle buttonDisabled = customTextStyle(
    fontSize: 14,
    height: 1.3,
    fontWeightName: FontWeightName.semiBold,
    color: AppColors.grey600,
  );

  // Old styles kept for backward compatibility
  static final TextStyle regular = customTextStyle(
    fontSize: 16,
    fontWeightName: FontWeightName.regular,
    color: AppColors.black,
  );

  static final TextStyle title = customTextStyle(
    fontSize: 18,
    fontWeightName: FontWeightName.bold,
    color: AppColors.black,
  );

  static final TextStyle buttonWhiteText = customTextStyle(
    fontSize: 16,
    fontWeightName: FontWeightName.bold,
    color: AppColors.white,
  );

  static final TextStyle buttonGreyText = customTextStyle(
    fontSize: 16,
    fontWeightName: FontWeightName.bold,
    color: AppColors.grey600,
  );

  static final TextStyle hintTextField = customTextStyle(
    fontSize: 16,
    fontWeightName: FontWeightName.regular,
    color: AppColors.grey500,
  );

  static final TextStyle hintTextFieldWhite = customTextStyle(
    fontSize: 16,
    fontWeightName: FontWeightName.regular,
    color: AppColors.white.withValues(alpha: 0.7),
  );

  static final TextStyle textField = customTextStyle(
    fontSize: 16,
    fontWeightName: FontWeightName.regular,
    color: AppColors.black,
  );

  static final TextStyle textFieldWhite = customTextStyle(
    fontSize: 16,
    fontWeightName: FontWeightName.regular,
    color: AppColors.white,
  );

  static final TextStyle errorTextField = customTextStyle(
    fontSize: 16,
    fontWeightName: FontWeightName.regular,
    color: AppColors.red,
  );
}