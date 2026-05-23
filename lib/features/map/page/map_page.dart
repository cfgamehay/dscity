import 'dart:async';

import 'package:dscity_mobile_app/core/app_config/map_config.dart';
import 'package:dscity_mobile_app/data/models/map/rental_location.dart';
import 'package:dscity_mobile_app/features/map/widgets/map_pannel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/enum.dart';
import '../../../core/extensions/MapFilterType.dart';
import '../../../core/theme/app_colors.dart';
import '../../parking/page/parking_detail_page.dart';
import '../../sharing/page/share_detail_page.dart';
import '../../vehicle/page/vehicle_detail_page.dart';
import '../provider/map_provider.dart';
import '../provider/map_state.dart';
import '../widgets/map_filter_chips.dart';
import '../widgets/map_search_bar.dart';
import '../widgets/track_asia_map_view.dart';

class MapPage extends ConsumerStatefulWidget {
  final bool showBackButton;
  final String? initialLocationId;

  const MapPage({
    super.key,
    this.showBackButton = false,
    this.initialLocationId,
  });

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (widget.initialLocationId != null) {
        await ref
            .read(mapProvider.notifier)
            .openLocationById(widget.initialLocationId!);
        return;
      }

      await ref.read(mapProvider.notifier).firstLoad();
    });
  }

  void _selectedLocation(RentalLocation location) {
    ref.read(mapProvider.notifier).selectLocation(location);
  }

  Future<void> _redirectToDetailPage(RentalLocation? selectedLocation) async {
    if (selectedLocation == null || !mounted) return;

    switch (selectedLocation.type) {
      case MapFilterType.car:
      case MapFilterType.motorbike:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => VehicleDetailPage(locationId: selectedLocation.id),
          ),
        );
        break;
      case MapFilterType.parking:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ParkingDetailPage(locationId: selectedLocation.id),
          ),
        );
        break;
      case MapFilterType.sharing:
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ShareDetailPage(locationId: selectedLocation.id),
          ),
        );
        break;
    }
  }

  void _showFilterSheet(List<String> provinces) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final state = ref.watch(mapProvider);

        return SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Bộ lọc',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    if (state.selectedProvince.isNotEmpty ||
                        state.selectedSort != MapSortType.nearest)
                      TextButton(
                        onPressed: () {
                          ref.read(mapProvider.notifier).resetFilters();
                          Navigator.pop(context);
                        },
                        child: const Text('loại bỏ thay đổi'),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Khu vực',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.selectedProvince,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: provinces.map((province) {
                        final label = province.isEmpty
                            ? 'Tất cả khu vực'
                            : province;
                        return DropdownMenuItem<String>(
                          value: province,
                          child: Text(label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        ref
                            .read(mapProvider.notifier)
                            .changeProvince(value ?? '');
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sắp xếp theo',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<MapSortType>(
                      value: state.selectedSort,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: const [
                        DropdownMenuItem(
                          value: MapSortType.nearest,
                          child: Text('Gần nhất'),
                        ),
                        DropdownMenuItem(
                          value: MapSortType.cheapest,
                          child: Text('Rẻ nhất'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(mapProvider.notifier).changeSort(value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapProvider);
    final provinces = ref.read(mapProvider.notifier).getAvailableProvinces();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: MapCanvasWidget(
              styleUrl: MapConfig.styleUrl,
              locations: state.locations,
              userLatitude: state.userLatitude,
              userLongitude: state.userLongitude,
              selectedLocation: state.selectedLocation,
              selectedLocationRequestId: state.selectedLocationRequestId,
              focusUserLocationRequestId: state.focusUserLocationRequestId,
              unselectedLocation:
                  ref.read(mapProvider.notifier).unselectedLocation,
              setCurrentSelectedLocation:
                  ref.read(mapProvider.notifier).selectLocation,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      if (widget.showBackButton) ...[
                        Material(
                          color: AppColors.surface,
                          shape: const CircleBorder(),
                          elevation: 2,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: MapSearchBar(
                          searchInputChange:
                              ref.read(mapProvider.notifier).updateSearchKeyword,
                          showBottomModal:
                              ref.read(mapProvider.notifier).showBottomModal,
                          onOpenFilter: () => _showFilterSheet(provinces),
                          isFilterActive: state.selectedProvince.isNotEmpty ||
                              state.selectedSort != MapSortType.nearest,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  MapFilterChips(
                    selectedFilter: state.selectedFilter,
                    onChanged: ref.read(mapProvider.notifier).changeFilter,
                  ),
                ],
              ),
            ),
          ),
          MapPanel(
            isLoading: state.isLoading,
            isShowDetailBottomModal: state.isShowDetailBottomModal,
            locations: state.locations,
            hideBottomModal: () {
              ref.read(mapProvider.notifier).hideBottomModal();
            },
            selectedLocation: _selectedLocation,
          ),
          if (!state.isShowDetailBottomModal)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(mapProvider.notifier).toggleBottomModal();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.keyboard_arrow_up),
                          SizedBox(width: 6),
                          Text('Gần bạn'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (state.isShowDetailForMarker)
                    GestureDetector(
                      onTap: () {
                        _redirectToDetailPage(state.selectedLocation);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.info_outline),
                            SizedBox(width: 6),
                            Text('Chi tiết'),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      ref.read(mapProvider.notifier).requestFocusUserLocation();
                      ref.read(mapProvider.notifier).unselectedLocation();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Icon(Icons.my_location, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
