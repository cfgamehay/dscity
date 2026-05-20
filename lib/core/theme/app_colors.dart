import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand colors
  static const Color brandBlue = Color(0xFF052650);
  static const Color brandGreen = Color(0xFF088348);
  static const Color brandGreenDark = Color(0xFF086C4A);
  static const Color brandYellow = Color(0xFFFCC91A);
  static const Color brandWhite = Color(0xFFFDFDFD);

  // Semantic colors
  static const Color primary = brandBlue;
  static const Color onPrimary = brandWhite;

  static const Color secondary = brandGreen;
  static const Color onSecondary = brandWhite;

  static const Color tertiary = brandYellow;
  static const Color onTertiary = brandBlue;

  static const Color background = brandWhite;
  static const Color onBackground = brandBlue;

  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = brandBlue;

  static const Color surfaceVariant = Color(0xFFF5F7FA);
  static const Color onSurfaceVariant = Color(0xFF5B6B86);

  static const Color outline = Color(0xFFC8CED9);
  static const Color outlineVariant = Color(0xFFE0E4EA);

  static const Color error = red;
  static const Color onError = white;

  static const Color warning = brandYellow;
  static const Color onWarning = brandBlue;

  static const Color success = brandGreen;
  static const Color onSuccess = white;

  static const Color info = blue;
  static const Color onInfo = white;

  // Fixed common colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF15294B);
  static const Color blue = Color(0xFF3366FF);
  static const Color blue2 = Color(0xFF183773);
  static const Color red = Color(0xFFE33629);
  static const Color red2 = Color(0xFFFFE7E5);
  static const Color yellow = Color(0xFFF4B539);
  static const Color yellow1 = Color(0xFFF4E44F);
  static const Color yellow2 = Color(0xFFFFECC8);
  static const Color green = Color(0xFF53BC5D);
  static const Color green2 = Color(0xFFCFEDD5);
  static const Color chatAdminColor = Color(0xFFF4FEFE);

  // Neutrals
  static const Color grey50 = Color(0xFFFCFCFD);
  static const Color grey100 = Color(0xFFF1F3F6);
  static const Color grey200 = Color(0xFFE0E4EA);
  static const Color grey300 = Color(0xFFC8CED9);
  static const Color grey400 = Color(0xFFA8B3C4);
  static const Color grey500 = Color(0xFF8292AA);
  static const Color grey600 = Color(0xFF5B6B86);
  static const Color grey700 = Color(0xFF384252);
  static const Color grey800 = Color(0xFF242B35);
  static const Color grey900 = Color(0xFF191D24);
  static const Color grey950 = Color(0xFF15181E);

  // Text field dark variants
  static const Color darkFillColorTextField = Color(0xFF001835);
  static const Color darkBorderColorTextField = Color(0xFF082545);
}