import 'package:dscity_mobile_app/core/extensions/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/theme.dart';

class ShareRouteCard extends StatelessWidget {
  final String routeTitle;
  final String departureTime;
  final String durationLabel;
  final int pricePerSeat;
  final int availableSeats;

  const ShareRouteCard({
    super.key,
    required this.routeTitle,
    required this.departureTime,
    required this.durationLabel,
    required this.pricePerSeat,
    required this.availableSeats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            routeTitle,
            style: const TextStyle(
              color: AppColors.onPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$departureTime • $durationLabel',
            style: const TextStyle(
              color: AppColors.onPrimary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _WhiteChip(label: 'Còn $availableSeats chỗ'),
              _WhiteChip(label: '${(pricePerSeat.toCurrency(isSymbol: true))}/người'),
            ],
          ),
        ],
      ),
    );
  }

}

class _WhiteChip extends StatelessWidget {
  final String label;

  const _WhiteChip({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}