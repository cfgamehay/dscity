import 'package:dscity_mobile_app/core/extensions/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/theme.dart';
import '../../../../data/models/parking/parking_detail.dart';
import '../widgets/parking_action_button.dart';
import '../widgets/parking_detail_header.dart';
import '../widgets/parking_feature_chip_row.dart';
import '../widgets/parking_hero_image.dart';
import '../widgets/parking_info_row.dart';
import '../widgets/parking_meta_row.dart';
import '../widgets/parking_payment_section.dart';
import '../widgets/parking_title_section.dart';


class ParkingDetailContent extends StatelessWidget {
  static const double _imageHeight = ParkingHeroImage.height;
  static const double _contentTop = _imageHeight - 60;

  final ParkingDetail detail;
  final VoidCallback onBack;
  final VoidCallback onFavorite;
  final VoidCallback onBooking;

  const ParkingDetailContent({
    super.key,
    required this.detail,
    required this.onBack,
    required this.onFavorite,
    required this.onBooking,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Stack(
      children: [
        Column(
          children: [
            ParkingHeroImage(imageUrl: detail.imageUrl),
            Expanded(
              child: Container(color: AppColors.background),
            ),
          ],
        ),
        SafeArea(
          child: ParkingDetailHeader(
            onBack: onBack,
            onAction: onFavorite,
          ),
        ),
        Positioned.fill(
          top: _contentTop,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.08),
                    blurRadius: 18,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ParkingTitleSection(
                      title: detail.title,
                      rating: detail.rating,
                      reviewCount: detail.reviewCount,
                      distanceLabel: detail.distanceLabel,
                    ),
                    const SizedBox(height: 14),
                    ParkingMetaRow(
                      parkingTypeLabel: detail.parkingTypeLabel,
                      securityLabel: detail.securityLabel,
                      elevatorLabel: detail.elevatorLabel,
                    ),
                    const SizedBox(height: 18),
                    const Divider(color: AppColors.outlineVariant, height: 1),
                    const SizedBox(height: 10),
                    ParkingInfoRow(
                      label: 'Giờ hoạt động',
                      value: detail.openingHours,
                    ),
                    ParkingInfoRow(
                      label: 'Giá',
                      value:
                      '${detail.pricePerHour.toCurrency(isSymbol: true)}/giờ\n${detail.pricePerDay.toCurrency(isSymbol: true)}/ngày',
                    ),
                    ParkingInfoRow(
                      label: 'Còn trống',
                      value: detail.availableSlots,
                    ),
                    ParkingPaymentSection(
                      label: 'Phương thức thanh toán',
                      methods: detail.paymentMethods,
                    ),
                    const SizedBox(height: 12),
                    ParkingFeatureChipRow(
                      features: detail.features,
                    ),
                    const SizedBox(height: 18),
                    ParkingActionButton(
                      text: 'Đặt chỗ ngay',
                      onPressed: onBooking,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
