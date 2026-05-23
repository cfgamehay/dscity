import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class ParkingHeroImage extends StatelessWidget {
  static const double height = 280;

  final String imageUrl;

  const ParkingHeroImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                width: double.infinity,
                height: height,
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
      ),
    );
  }
}
