import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../provider/vehicle_detail_state.dart';

class VehicleDetailPriceCard extends StatelessWidget {
  final String basePriceLabel;
  final String pricePerHour;
  final String pricePerDay;
  final String pricePerWeek;
  final VehiclePriceOption selectedPriceOption;
  final ValueChanged<VehiclePriceOption> onSelectPriceOption;

  const VehicleDetailPriceCard({
    super.key,
    required this.basePriceLabel,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.pricePerWeek,
    required this.selectedPriceOption,
    required this.onSelectPriceOption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          _VehiclePriceRow(
            label: 'Giá thuê',
            value: basePriceLabel,
            isHighlighted: false,
            onTap: null,
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          _VehiclePriceRow(
            label: 'Theo giờ',
            value: pricePerHour,
            isHighlighted: selectedPriceOption == VehiclePriceOption.hour,
            onTap: () => onSelectPriceOption(VehiclePriceOption.hour),
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          _VehiclePriceRow(
            label: 'Theo ngày',
            value: pricePerDay,
            isHighlighted: selectedPriceOption == VehiclePriceOption.day,
            onTap: () => onSelectPriceOption(VehiclePriceOption.day),
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          _VehiclePriceRow(
            label: 'Theo tuần',
            value: pricePerWeek,
            isHighlighted: selectedPriceOption == VehiclePriceOption.week,
            onTap: () => onSelectPriceOption(VehiclePriceOption.week),
          ),
        ],
      ),
    );
  }
}

class _VehiclePriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlighted;
  final VoidCallback? onTap;

  const _VehiclePriceRow({
    required this.label,
    required this.value,
    required this.isHighlighted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isHighlighted
                  ? AppColors.secondary
                  : AppColors.onSurfaceVariant,
            ),
          ),
          if (isHighlighted) ...[
            const SizedBox(width: 6),
            const Icon(
              Icons.check_circle,
              size: 16,
              color: AppColors.secondary,
            ),
          ],
        ],
      ),
    );

    final content = isHighlighted
        ? Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.green2.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.18),
        ),
      ),
      child: row,
    )
        : row;

    if (onTap == null) return content;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: content,
    );
  }
}