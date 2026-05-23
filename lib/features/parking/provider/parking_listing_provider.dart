import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/constants/enum.dart';
import '../../../core/services/location_services.dart';
import '../../../data/models/map/rental_location.dart';
import '../../../data/repositories/map/mock_rental_location_repository.dart';
import '../../../data/repositories/map/rental_location_repository.dart';
import 'parking_listing_state.dart';

final parkingListingProvider =
NotifierProvider<ParkingListingProvider, ParkingListingState>(
  ParkingListingProvider.new,
);

class ParkingListingProvider extends Notifier<ParkingListingState> {
  late final RentalLocationRepository _repository;

  @override
  ParkingListingState build() {
    _repository = MockRentalLocationRepository();
    return const ParkingListingState();
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
      sortType:
          _canSortByDistance ? state.sortType : ParkingSortType.cheapest,
    );

    _applyFilters();
  }

  Future<void> firstLoad() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final items = await _repository.getLocations();

      final parkingItems =
          items.where((item) => item.type == MapFilterType.parking).toList();

      state = state.copyWith(
        isLoading: false,
        allItems: parkingItems,
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

  void changeTypeFilter(ParkingTypeFilter filter) {
    state = state.copyWith(typeFilter: filter);
    _applyFilters();
  }

  void toggleAvailableOnly() {
    state = state.copyWith(onlyAvailable: !state.onlyAvailable);
    _applyFilters();
  }

  void toggleOpen24hOnly() {
    state = state.copyWith(onlyOpen24h: !state.onlyOpen24h);
    _applyFilters();
  }

  void changeSortType(ParkingSortType sortType) {
    if (sortType == ParkingSortType.nearest && !_canSortByDistance) {
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

    switch (state.typeFilter) {
      case ParkingTypeFilter.all:
        break;
      case ParkingTypeFilter.indoor:
        result = result.where((item) => item.isIndoor);
        break;
      case ParkingTypeFilter.outdoor:
        result = result.where((item) => !item.isIndoor);
        break;
    }

    if (state.onlyAvailable) {
      result = result.where((item) => item.hasAvailableSlot);
    }

    if (state.onlyOpen24h) {
      result = result.where((item) => item.isOpen24h);
    }

    final list = result.toList();

    switch (state.sortType) {
      case ParkingSortType.nearest:
        if (_canSortByDistance) {
          list.sort(
            (a, b) => (a.distanceInMeters ?? double.infinity).compareTo(
              b.distanceInMeters ?? double.infinity,
            ),
          );
        }
        break;
      case ParkingSortType.cheapest:
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
