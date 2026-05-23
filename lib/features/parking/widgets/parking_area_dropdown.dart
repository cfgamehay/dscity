import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class ParkingAreaDropdown extends StatelessWidget {
  final String value;
  final List<String> provinces;
  final ValueChanged<String> onChanged;

  const ParkingAreaDropdown({
    super.key,
    required this.value,
    required this.provinces,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: provinces.map((province) {
            return DropdownMenuItem<String>(
              value: province,
              child: Text(
                province.isEmpty ? 'Tất cả khu vực' : province,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            onChanged(newValue ?? '');
          },
        ),
      ),
    );
  }
}