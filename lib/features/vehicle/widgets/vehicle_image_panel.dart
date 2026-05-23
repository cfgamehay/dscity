import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class VehicleDetailImagePanel extends StatelessWidget {
  static const double height = 280;

  final String imageUrl;

  const VehicleDetailImagePanel({
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
        child: Container(
          width: double.infinity,
          color: AppColors.surfaceVariant,
          alignment: Alignment.center,
          child: imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: height,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.two_wheeler,
                      size: 90,
                      color: AppColors.primary,
                    );
                  },
                )
              : const Icon(
                  Icons.two_wheeler,
                  size: 90,
                  color: AppColors.primary,
                ),
        ),
      ),
    );
  }
}
