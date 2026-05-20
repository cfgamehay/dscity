import 'package:flutter/material.dart';

import '../../../core/constants/enum.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/model/map/rental_location.dart';

class MapPannel extends StatelessWidget {
  final bool isLoading;
  final bool isShowDetailBottomModal;
  final List<RentalLocation> locations;
  final VoidCallback toggleBottomModal;
  final ValueChanged<RentalLocation> selectedLocation;

  const MapPannel({
    super.key,
    required this.isLoading,
    required this.isShowDetailBottomModal,
    required this.locations,
    required this.toggleBottomModal,
    required this.selectedLocation,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.bottomCenter,
      child: IgnorePointer(
        ignoring: !isShowDetailBottomModal,
        child: AnimatedSlide(
          offset: isShowDetailBottomModal
              ? Offset.zero
              : const Offset(0, 3),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: isLoading
                ? const Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            )
                : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Gần bạn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: color.primary,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: toggleBottomModal,
                      child: const Icon(Icons.keyboard_arrow_down, size: 30,),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...locations.map(
                      (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => selectedLocation(item),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: color.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: color.outline.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: color.primary,
                              child: Icon(
                                item.type == MapFilterType.motorbike
                                    ? Icons.two_wheeler
                                    : Icons.local_parking,
                                color: color.onPrimary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: color.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.distanceText} • ${item.statusText}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              item.priceText,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}