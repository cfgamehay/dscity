import 'package:dscity_mobile_app/features/vehicle/widgets/vehicle_feature_row.dart';
import 'package:dscity_mobile_app/features/vehicle/widgets/vehicle_image_panel.dart';
import 'package:dscity_mobile_app/features/vehicle/widgets/vehicle_price_card.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/vehicle/vehicle_detail.dart';
import '../provider/vehicle_detail_state.dart';
import 'vehicle_detail_cta_button.dart';
import 'vehicle_detail_header.dart';
import 'vehicle_detail_meta_row.dart';

class VehicleDetailContent extends StatelessWidget {
  final VehicleDetail detail;
  final VehiclePriceOption selectedPriceOption;
  final VoidCallback onBack;
  final VoidCallback onAction;
  final VoidCallback onPrimaryAction;
  final ValueChanged<VehiclePriceOption> onSelectPriceOption;
  final IconData actionIcon;

  const VehicleDetailContent({
    super.key,
    required this.detail,
    required this.selectedPriceOption,
    required this.onBack,
    required this.onAction,
    required this.onPrimaryAction,
    required this.onSelectPriceOption,
    this.actionIcon = Icons.favorite_border,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Stack(
            children: [
              VehicleDetailImagePanel(imageUrl: detail.imageUrl),
              Positioned(
                top: 8,
                left: 16,
                right: 16,
                child: VehicleDetailHeader(
                  onBack: onBack,
                  onAction: onAction,
                  actionIcon: actionIcon,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      detail.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  VehicleDetailMetaRow(
                    transmissionLabel: detail.transmissionLabel,
                    specLabel: detail.specLabel,
                    fuelLabel: detail.fuelLabel,
                    rating: detail.rating,
                    reviewCount: detail.reviewCount,
                  ),
                  const SizedBox(height: 18),
                  VehicleDetailPriceCard(
                    basePriceLabel: 'Số tiền/Thời gian',
                    pricePerHour: detail.pricePerHour,
                    pricePerDay: detail.pricePerDay,
                    pricePerWeek: detail.pricePerWeek,
                    selectedPriceOption: selectedPriceOption,
                    onSelectPriceOption: onSelectPriceOption,
                  ),
                  const SizedBox(height: 18),
                  VehicleDetailFeatureRow(features: detail.features),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            child: VehicleDetailCtaButton(
              text: detail.buttonText,
              onPressed: onPrimaryAction,
            ),
          ),
        ],
      ),
    );
  }
}