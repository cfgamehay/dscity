import 'package:flutter/material.dart';

import '../../../core/constants/enum.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/map/rental_location.dart';

class MapPanel extends StatelessWidget {
  final bool isLoading;
  final bool isShowDetailBottomModal;
  final List<RentalLocation> locations;
  final VoidCallback hideBottomModal;
  final ValueChanged<RentalLocation> selectedLocation;

  const MapPanel({
    super.key,
    required this.isLoading,
    required this.isShowDetailBottomModal,
    required this.locations,
    required this.hideBottomModal,
    required this.selectedLocation,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final shouldShowLoading = isLoading && locations.isEmpty;

    return Align(
      alignment: Alignment.bottomCenter,
      child: IgnorePointer(
        ignoring: !isShowDetailBottomModal,
        child: AnimatedSlide(
          offset: isShowDetailBottomModal ? Offset.zero : const Offset(0, 2),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            height: 320,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
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
            child: shouldShowLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Gần bạn',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              hideBottomModal();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      locations.isNotEmpty
                          ? Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: locations.map((item) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(18),
                                        onTap: () {
                                          selectedLocation(item);
                                          hideBottomModal();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                            color: color.surface,
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                            border: Border.all(
                                              color: color.outline.withValues(
                                                alpha: 0.4,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 22,
                                                backgroundColor:
                                                    AppColors.primary,
                                                child: Icon(
                                                  item.type ==
                                                          MapFilterType
                                                              .motorbike
                                                      ? Icons.two_wheeler
                                                      : Icons.local_parking,
                                                  color: AppColors.onPrimary,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      '${item.displayDistanceText} - ${item.statusText}',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .green
                                                            .shade700,
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
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text('Không tìm thấy nơi phù hợp'),
                                ),
                              ],
                            ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
