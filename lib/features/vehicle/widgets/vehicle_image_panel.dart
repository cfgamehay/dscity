import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class VehicleDetailImagePanel extends StatelessWidget {
  final String imageUrl;

  const VehicleDetailImagePanel({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: imageUrl.isNotEmpty
          ? Image.network(
        imageUrl,
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
    );
  }
}