import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/constants/enum.dart';
import '../../../core/services/location_services.dart';
import '../../../data/models/map/rental_location.dart';
import '../../../data/repositories/map/mock_rental_location_repository.dart';
import '../../../data/repositories/map/rental_location_repository.dart';
import 'vehicle_listing_state.dart';

final vehicleListingProvider = NotifierProvider<
    VehicleListingProvider, VehicleListingState>(
  VehicleListingProvider.new,
);

class VehicleListingProvider extends Notifier<VehicleListingState> {
  late final RentalLocationRepository _repository;
  MapFilterType _vehicleType = MapFilterType.car;

  @override
  VehicleListingState build() {
    _repository = MockRentalLocationRepository();
    return const VehicleListingState();
  }

  void configureType(MapFilterType type) {
    if (_vehicleType == type && state.vehicleType == type) {
      return;
    }

    _vehicleType = type;
    state = VehicleListingState(vehicleType: type);
  }

  Future<void> _loadUserLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      state = state.copyWith(
        isLocationServiceEnabled: false,
        hasLocationPermission: false,
      );
      return;
    }

    final position = await LocationService.getCurrentPosition();

    if (position == null) {
      state = state.copyWith(
        isLocationServiceEnabled: true,
        hasLocationPermission: false,
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

      return item.copyWith(distanceInMeters: distance);
    }).toList();
  }

  Future<void> _refreshLocationData() async {
    await _loadUserLocation();

    final itemsWithDistance = _attachDistance(
      state.allItems,
      state.userLatitude,
      state.userLongitude,
    );

    state = state.copyWith(
      allItems: itemsWithDistance,
      sortType: _canSortByDistance ? state.sortType : VehicleSortType.cheapest,
    );

    _applyFilters();
  }

  Future<void> firstLoad(MapFilterType type) async {
    configureType(type);
    state = state.copyWith(isLoading: true, error: null);

    try {
      final items = await _repository.getLocations();
      final vehicleItems = items
          .where((item) => item.type == _vehicleType)
          .toList();

      state = state.copyWith(
        isLoading: false,
        allItems: vehicleItems,
      );

      _applyFilters();
      unawaited(_refreshLocationData());
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void updateSearchKeyword(String value) {
    state = state.copyWith(searchKeyword: value);
    _applyFilters();
  }

  void changeProvince(String province) {
    state = state.copyWith(selectedProvince: province);
    _applyFilters();
  }

  void toggleAvailableOnly() {
    state = state.copyWith(onlyAvailable: !state.onlyAvailable);
    _applyFilters();
  }

  void changeSortType(VehicleSortType sortType) {
    if (sortType == VehicleSortType.nearest && !_canSortByDistance) {
      return;
    }

    state = state.copyWith(sortType: sortType);
    _applyFilters();
  }

  List<String> getAvailableProvinces() {
    final provinces = state.allItems.map((e) => e.province).toSet().toList()
      ..sort();
    return [''] + provinces;
  }

  void _applyFilters() {
    Iterable<RentalLocation> result = state.allItems;

    final keyword = state.searchKeyword.trim();
    if (keyword.isNotEmpty) {
      result = result.where((item) => item.matchesKeyword(keyword));
    }

    if (state.selectedProvince.trim().isNotEmpty) {
      result = result.where((item) => item.province == state.selectedProvince);
    }

    if (state.onlyAvailable) {
      result = result.where(
        (item) =>
            item.hasAvailableSlot ||
            item.statusText.toLowerCase().contains('còn')
      );
    }

    final list = result.toList();

    switch (state.sortType) {
      case VehicleSortType.nearest:
        if (_canSortByDistance) {
          list.sort(
            (a, b) => (a.distanceInMeters ?? double.infinity).compareTo(
              b.distanceInMeters ?? double.infinity,
            ),
          );
        }
        break;
      case VehicleSortType.cheapest:
        list.sort((a, b) => a.priceValue.compareTo(b.priceValue));
        break;
    }

    state = state.copyWith(filteredItems: list);
  }

  bool get _canSortByDistance {
    return state.isLocationServiceEnabled &&
        state.hasLocationPermission &&
        state.userLatitude != null &&
        state.userLongitude != null;
  }
}
