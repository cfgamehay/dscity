import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class ParkingHeroImage extends StatelessWidget {
  final String imageUrl;

  const ParkingHeroImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: imageUrl.isNotEmpty
          ? Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            color: AppColors.surfaceVariant,
            alignment: Alignment.center,
            child: const Icon(
              Icons.local_parking,
              size: 72,
              color: AppColors.primary,
            ),
          );
        },
      )
          : Container(
        color: AppColors.surfaceVariant,
        alignment: Alignment.center,
        child: const Icon(
          Icons.local_parking,
          size: 72,
          color: AppColors.primary,
        ),
      ),
    );
  }
}