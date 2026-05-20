import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension CurrencyFormat on num {
  String toCurrency({String languageCode = 'vi', bool isSymbol = false}) {
    String locale;
    String symbol;
    switch (languageCode) {
      case 'ko':
        locale = 'ko_KR';
        symbol = '₩'; // South Korean Won
        break;
      case 'en':
        locale = 'en_US';
        symbol = '\$'; // US Dollar
        break;
      case 'vi':
      default:
        locale = 'vi_VN';
        symbol = '₫'; // Vietnamese Dong
    }

    final format = NumberFormat.currency(
      locale: locale,
      symbol: isSymbol ? symbol : '',
    );
    return format.format(this);
  }
}

class CurrencyFormatter extends TextInputFormatter {
  //   final NumberFormat _formatter = NumberFormat.currency(
  //     locale: 'vi_VN',
  //     symbol: 'VND',
  //     decimalDigits: 0,
  //   );
  final NumberFormat _formatter = NumberFormat.decimalPattern(
    'vi_VN',
  ); // Chỉ format số, không có "VND"

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String filteredValue = newValue.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    ); // Giữ lại chỉ số
    if (filteredValue.isEmpty) return newValue;

    String formattedValue = _formatter.format(int.parse(filteredValue));

    int cursorPosition =
        newValue.selection.baseOffset +
        (formattedValue.length - newValue.text.length);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(
        offset: cursorPosition.clamp(0, formattedValue.length),
      ),
    );
  }
}
