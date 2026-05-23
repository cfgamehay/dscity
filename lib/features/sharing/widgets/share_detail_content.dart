import 'package:dscity_mobile_app/core/extensions/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/models/sharing/share_detail.dart';
import 'share_action_button.dart';
import 'share_detail_header.dart';
import 'share_route_card.dart';
import 'share_rule_chip_row.dart';
import 'share_stop_timeline.dart';

class ShareDetailContent extends StatelessWidget {
  final ShareDetail detail;
  final int selectedSeats;
  final int totalPrice;
  final VoidCallback onBack;
  final VoidCallback onFavorite;
  final VoidCallback onJoin;
  final ValueChanged<int> onChangeSeats;

  const ShareDetailContent({
    super.key,
    required this.detail,
    required this.selectedSeats,
    required this.totalPrice,
    required this.onBack,
    required this.onFavorite,
    required this.onJoin,
    required this.onChangeSeats,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        child: Column(
          children: [
            ShareDetailHeader(
              onBack: onBack,
              onAction: onFavorite,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ShareRouteCard(
                      routeTitle: detail.routeTitle,
                      departureTime: detail.departureTime,
                      durationLabel: detail.durationLabel,
                      pricePerSeat: detail.pricePerSeat,
                      availableSeats: detail.availableSeats,
                    ),
                    const SizedBox(height: 16),
                    ShareStopTimeline(stopPoints: detail.stopPoints),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.outlineVariant),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nội quy',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ShareRuleChipRow(rules: detail.rules),
                          const SizedBox(height: 14),
                          const Text(
                            'Ghi chú',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            detail.note,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.outlineVariant),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Số ghế',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: selectedSeats > 1
                                ? () => onChangeSeats(selectedSeats - 1)
                                : null,
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '$selectedSeats',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: selectedSeats < detail.availableSeats
                                ? () => onChangeSeats(selectedSeats + 1)
                                : null,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            totalPrice.toCurrency(isSymbol: true),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ShareActionButton(
              text: detail.buttonText,
              onPressed: onJoin,
            ),
          ],
        ),
      ),
    );
  }

}
