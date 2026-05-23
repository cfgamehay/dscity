import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/enum.dart';
import '../../../core/theme/theme.dart';
import '../../../data/models/map/rental_location.dart';
import '../../map/page/map_page.dart';
import '../../parking/widgets/parking_area_dropdown.dart';
import '../provider/vehicle_listing_provider.dart';
import '../widgets/vehicle_filter_chip_row.dart';
import '../widgets/vehicle_search_bar.dart';
import '../widgets/vehicle_sort_selector.dart';
import '../widgets/vehicle_suggestion_card.dart';

class VehiclePage extends ConsumerStatefulWidget {
  final MapFilterType type;

  const VehiclePage({
    super.key,
    required this.type,
  });

  @override
  ConsumerState<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends ConsumerState<VehiclePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(vehicleListingProvider.notifier).firstLoad(widget.type);
    });
  }

  void _openVehicleOnMap(RentalLocation item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MapPage(
          showBackButton: true,
          initialLocationId: item.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehicleListingProvider);
    final notifier = ref.read(vehicleListingProvider.notifier);
    final provinces = notifier.getAvailableProvinces();
    final isMotorbike = widget.type == MapFilterType.motorbike;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isMotorbike ? 'Thuê xe máy' : 'Thuê ô tô'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VehicleSearchBar(
              hintText: isMotorbike
                  ? 'Tìm xe máy, khu vực...'
                  : 'Tìm ô tô, khu vực...',
              onChanged: notifier.updateSearchKeyword,
            ),
            const SizedBox(height: 12),
            ParkingAreaDropdown(
              value: state.selectedProvince,
              provinces: provinces,
              onChanged: notifier.changeProvince,
            ),
            const SizedBox(height: 12),
            VehicleFilterChipRow(
              onlyAvailable: state.onlyAvailable,
              onToggleAvailable: notifier.toggleAvailableOnly,
            ),
            const SizedBox(height: 12),
            VehicleSortSelector(
              currentSort: state.sortType,
              canSortByNearest: state.isLocationServiceEnabled &&
                  state.hasLocationPermission &&
                  state.userLatitude != null &&
                  state.userLongitude != null,
              onChanged: notifier.changeSortType,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.filteredItems.isEmpty
                      ? const Center(
                          child: Text(
                            'Không tìm thấy phương tiện phù hợp',
                            style: TextStyle(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: state.filteredItems.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = state.filteredItems[index];

                            return VehicleSuggestionCard(
                              item: item,
                              onTap: () => _openVehicleOnMap(item),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
