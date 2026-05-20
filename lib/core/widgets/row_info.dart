import '../theme/theme.dart';
import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  final String title;
  final String value;
  final int flexTitle;
  final int flexValue;

  const RowInfo({
    super.key,
    required this.title,
    required this.value,
    this.flexTitle = 5,
    this.flexValue = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: flexTitle,
            child: Text(
              title,
              style: AppTextStyles.customTextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: flexValue,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.customTextStyle(
                fontSize: 15,
                fontWeightName: FontWeightName.semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
