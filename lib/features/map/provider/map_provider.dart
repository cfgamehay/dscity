import 'package:dscity_mobile_app/features/map/provider/map_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/constants/enum.dart';
import '../../../core/services/location_services.dart';
import '../../../data/models/map/rental_location.dart';
import '../../../data/repositories/map/mock_rental_location_repository.dart';
import '../../../data/repositories/map/rental_location_repository.dart';

final mapProvider = NotifierProvider<MapProvider, MapState>(
  MapProvider.new,
);

class MapProvider extends Notifier<MapState> {
  late final RentalLocationRepository _repository;
  List<RentalLocation> _allLocations = const [];
  bool _hasLoadedOnce = false;

  @override
  MapState build() {
    _repository = MockRentalLocationRepository();
    return const MapState();
  }

  Future<void> _loadUserLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      state = state.copyWith(
        isLocationServiceEnabled: false,
        hasLocationPermission: false,
        userLatitude: null,
        userLongitude: null,
      );
      return;
    }

    final position = await LocationService.getCurrentPosition();

    if (position == null) {
      state = state.copyWith(
        isLocationServiceEnabled: true,
        hasLocationPermission: false,
        userLatitude: null,
        userLongitude: null,
      );
      return;
    }

    state = state.copyWith(
      isLocationServiceEnabled: true,
      hasLocationPermission: true,
      userLatitude: position.latitude,
      userLongitude: position.longitude,
    );
  }

  List<RentalLocation> _attachDistance(
      List<RentalLocation> items,
      double? userLatitude,
      double? userLongitude,
      ) {
    if (userLatitude == null || userLongitude == null) {
      return items;
    }

    return items.map((item) {
      final distance = Geolocator.distanceBetween(
        userLatitude,
        userLongitude,
        item.latitude,
        item.longitude,
      );

      return item.copyWith(
        distanceInMeters: distance,
      );
    }).toList();
  }

  Future<void> _loadLocations() async {
    final items = await _repository.getLocations();

    _allLocations = _attachDistance(
      items,
      state.userLatitude,
      state.userLongitude,
    );
  }

  Future<void> firstLoad({bool forceRefresh = false}) async {
    if (_hasLoadedOnce && !forceRefresh) {
      _applyFilters();
      return;
    }

    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      await _loadUserLocation();
      await _loadLocations();
      _applyFilters();
      _hasLoadedOnce = true;

      state = state.copyWith(
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> openLocationById(String locationId) async {
    await firstLoad();
    selectLocationById(locationId);
  }

  void updateSearchKeyword(String value) {
    state = state.copyWith(searchKeyword: value);
    _applyFilters();
  }

  void changeFilter(MapFilterType filter) {
    state = state.copyWith(selectedFilter: filter);
    _applyFilters();
  }

  void changeProvince(String province) {
    state = state.copyWith(selectedProvince: province);
    _applyFilters();
  }

  void changeSort(MapSortType sortType) {
    state = state.copyWith(selectedSort: sortType);
    _applyFilters();
  }

  void clearProvinceFilter() {
    if (state.selectedProvince.isEmpty) return;
    state = state.copyWith(selectedProvince: '');
    _applyFilters();
  }

  void resetFilters() {
    state = state.copyWith(
      selectedProvince: '',
      selectedSort: MapSortType.nearest,
    );
    _applyFilters();
  }

  void _applyFilters() {
    Iterable<RentalLocation> result = _allLocations;

    result = result.where((e) => e.type == state.selectedFilter);

    if (state.selectedProvince.trim().isNotEmpty) {
      result = result.where((e) => e.province == state.selectedProvince);
    }

    if (state.searchKeyword.trim().isNotEmpty) {
      final keyword = state.searchKeyword.trim();
      result = result.where((e) => e.matchesKeyword(keyword));
    }

    final list = result.toList();

    switch (state.selectedSort) {
      case MapSortType.nearest:
        if (_canSortByDistance) {
          list.sort(
            (a, b) => (a.distanceInMeters ?? double.infinity).compareTo(
              b.distanceInMeters ?? double.infinity,
            ),
          );
        }
        break;
      case MapSortType.cheapest:
        list.sort((a, b) => a.priceValue.compareTo(b.priceValue));
        break;
    }

    state = state.copyWith(locations: list);
  }

  void selectLocation(RentalLocation location) {
    state = state.copyWith(
      selectedLocation: location,
      selectedLocationRequestId: state.selectedLocationRequestId + 1,
      isShowDetailForMarker: true,
      isShowDetailBottomModal: false,
    );
  }

  void selectLocationById(String locationId) {
    RentalLocation? found;

    try {
      found = _allLocations.firstWhere((item) => item.id == locationId);
    } catch (_) {
      found = null;
    }

    if (found == null) return;

    state = state.copyWith(
      selectedFilter: found.type,
      searchKeyword: '',
      selectedProvince: '',
    );

    _applyFilters();

    state = state.copyWith(
      selectedLocation: found,
      selectedLocationRequestId: state.selectedLocationRequestId + 1,
      isShowDetailForMarker: true,
      isShowDetailBottomModal: false,
    );
  }

  void requestFocusUserLocation() {
    state = state.copyWith(
      focusUserLocationRequestId: state.focusUserLocationRequestId + 1,
    );
    unselectedLocation();
  }

  void unselectedLocation() {
    state = state.copyWith(isShowDetailForMarker: false);
  }

  void toggleBottomModal() {
    state = state.copyWith(
      isShowDetailBottomModal: !state.isShowDetailBottomModal,
    );
  }

  void showBottomModal() {
    if (state.isShowDetailBottomModal) return;
    state = state.copyWith(isShowDetailBottomModal: true);
  }

  void hideBottomModal() {
    state = state.copyWith(isShowDetailBottomModal: false);
  }

  List<String> getAvailableProvinces() {
    final provinces = _allLocations
        .map((e) => e.province)
        .toSet()
        .toList()
      ..sort();

    return [''] + provinces;
  }

  bool get _canSortByDistance {
    return state.isLocationServiceEnabled &&
        state.hasLocationPermission &&
        state.userLatitude != null &&
        state.userLongitude != null;
  }
}
