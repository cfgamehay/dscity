import 'package:intl/intl.dart';

class StringUtils {
  StringUtils._();

  static String formatToK(int value) {
    if (value >= 1000) {
      return '${(value / 1000).floor()}K';
    }
    return value.toString();
  }

  static DateTime getDateTimeFromServer(
    String dateTime, {
    String stringFormat = 'M/d/yyyy h:mm:ss a',
    bool isUtc = true,
  }) {
    try {
      return DateFormat(
        stringFormat,
      ).parse(dateTime.replaceAll('\u202F', ' '), isUtc).toLocal();
    } catch (e) {
      return DateTime.now();
    }
  }

  // Hàm định dạng số điện thoại
  static String formatPhoneNumber(String number, {String separator = ' '}) {
    if (number.length != 10) return number; // Kiểm tra độ dài hợp lệ
    return '${number.substring(0, 4)}$separator${number.substring(4, 7)}$separator${number.substring(7)}';
  }

  // Hàm định dạng địa chỉ
  static String formatAddress({
    String? address,
    String? ward,
    String? city,
    String? state,
  }) {
    return [
      address,
      ward,
      city,
      state,
    ].where((element) => element?.isNotEmpty ?? false).join(', ');
  }

  // Convert String to Int
  static int convertStringToInt(String value) {
    try {
      return int.parse(value);
    } catch (e) {
      return 0;
    }
  }

  // Convert String to Double
  static double convertStringToDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0;
    }
  }

  static String getRawMoney(String value) {
    try {
      return value.replaceAll(
        RegExp(r'[^0-9]'),
        '',
      ); // Loại bỏ dấu chấm, ký tự không phải số
    } catch (e) {
      return '0';
    }
  }

  static String obfuscateContact(String value) {
    if (value.contains('@')) {
      // Xử lý email
      final parts = value.split('@');
      final username = parts[0];
      final domain = parts[1];

      final hiddenLength = username.length > 2 ? username.length - 2 : 0;
      final hiddenPart = '*' * hiddenLength;
      final visiblePart = username.substring(0, 2);

      return '$visiblePart$hiddenPart@$domain';
    } else {
      // Xử lý số điện thoại
      if (value.length >= 5) {
        final visibleStart = value.substring(0, value.length - 5);
        return '$visibleStart*****';
      } else {
        return '*****';
      }
    }
  }

  // static Future<dynamic> getConfigValueByKey(String key) async {
  //   try {
  //     final configList = await SecureStorageUtil.readAppConfig();
  //     for (var config in configList) {
  //       if (config.keyName == key) {
  //         return config.keyValue;
  //       }
  //     }
  //     return '';
  //   } catch (e) {
  //     return '';
  //   }
  // }
}
