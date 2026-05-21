import 'dart:async';
import 'package:dscity_mobile_app/core/app_config/map_config.dart';
import 'package:dscity_mobile_app/data/model/map/rental_location.dart';
import 'package:dscity_mobile_app/features/map/widgets/map_pannel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/MapFilterType.dart';
import '../../../core/theme/app_colors.dart';
import '../provider/map_provider.dart';
import '../widgets/map_filter_chips.dart';
import '../widgets/map_search_bar.dart';
import '../widgets/track_asia_map_view.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(mapProvider.notifier).firstLoad();
    });
  }

  void _selectedLocation(RentalLocation location) {
    ref.read(mapProvider.notifier).selectLocation(location);
  }



  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapProvider);
    final color = Theme.of(context).colorScheme;

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
                focusUserLocationRequestId: state.focusUserLocationRequestId,
                unselectedLocation: ref.read(mapProvider.notifier).unselectedLocation,
                setCurrentSelectedLocation: ref.read(mapProvider.notifier).selectLocation,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MapSearchBar(
                      searchInputChange: ref.read(mapProvider.notifier).updateSearchKeyword,
                      showBottomModal: ref.read(mapProvider.notifier).showBottomModal,
                    ),
                    const SizedBox(height: 12),
                    MapFilterChips(selectedFilter: state.selectedFilter, onChanged: ref.read(mapProvider.notifier).changeFilter)
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
                          children: [
                            const Icon(Icons.keyboard_arrow_up),
                            const SizedBox(width: 6),
                            const Text('Gần bạn'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    if(state.isShowDetailForMarker)
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
                            children: [
                              const Icon(Icons.info_outline),
                              const SizedBox(width: 6),
                              const Text('Chi tiết'),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(width: 10),
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
