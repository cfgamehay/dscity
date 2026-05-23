import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/map/rental_location.dart';
import '../../map/page/map_page.dart';
import '../provider/parking_listing_provider.dart';
import '../widgets/ParkingFilterChipRow.dart';
import '../widgets/parking_area_dropdown.dart';
import '../widgets/parking_search_bar.dart';
import '../widgets/parking_sort_selector.dart';
import '../widgets/parking_suggestion_card.dart';

class ParkingPage extends ConsumerStatefulWidget {
  const ParkingPage({super.key});

  @override
  ConsumerState<ParkingPage> createState() => _ParkingPageState();
}

class _ParkingPageState extends ConsumerState<ParkingPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(parkingListingProvider.notifier).firstLoad();
    });
  }

  void _openParkingOnMap(RentalLocation item) {
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
    final state = ref.watch(parkingListingProvider);
    final provinces =
    ref.read(parkingListingProvider.notifier).getAvailableProvinces();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bãi đậu xe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ParkingSearchBar(
              onChanged:
              ref.read(parkingListingProvider.notifier).updateSearchKeyword,
            ),
            const SizedBox(height: 12),
            ParkingAreaDropdown(
              value: state.selectedProvince,
              provinces: provinces,
              onChanged:
              ref.read(parkingListingProvider.notifier).changeProvince,
            ),
            const SizedBox(height: 12),
            ParkingFilterChipRow(
              typeFilter: state.typeFilter,
              onlyAvailable: state.onlyAvailable,
              onlyOpen24h: state.onlyOpen24h,
              onTypeChanged:
              ref.read(parkingListingProvider.notifier).changeTypeFilter,
              onToggleAvailable:
              ref.read(parkingListingProvider.notifier).toggleAvailableOnly,
              onToggleOpen24h:
              ref.read(parkingListingProvider.notifier).toggleOpen24hOnly,
            ),
            const SizedBox(height: 12),
            ParkingSortSelector(
              currentSort: state.sortType,
              canSortByNearest: state.isLocationServiceEnabled &&
                  state.hasLocationPermission &&
                  state.userLatitude != null &&
                  state.userLongitude != null,
              onChanged:
              ref.read(parkingListingProvider.notifier).changeSortType,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: state.isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : state.filteredItems.isEmpty
                  ? const Center(
                child: Text(
                  'Không tìm thấy bãi đậu phù hợp',
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

                  return ParkingSuggestionCard(
                    item: item,
                    onTap: () => _openParkingOnMap(item),
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
