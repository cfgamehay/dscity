import 'package:dscity_mobile_app/core/constants/constants.dart';
import '../../../data/models/map/rental_location.dart';

enum MapSortType {
  nearest,
  cheapest,
}

class MapState {
  final bool isLoading;
  final bool hasLocationPermission;
  final double? userLatitude;
  final double? userLongitude;
  final MapFilterType selectedFilter;
  final String searchKeyword;
  final List<RentalLocation> locations;
  final RentalLocation? selectedLocation;
  final int selectedLocationRequestId;
  final bool isShowDetailBottomModal;
  final bool isShowDetailForMarker;
  final int focusUserLocationRequestId;
  final String selectedProvince;
  final MapSortType selectedSort;
  final bool isLocationServiceEnabled;
  final String? error;

  const MapState({
    this.isLoading = false,
    this.hasLocationPermission = false,
    this.selectedFilter = MapFilterType.parking,
    this.searchKeyword = '',
    this.locations = const [],
    this.selectedLocation,
    this.selectedLocationRequestId = 0,
    this.error,
    this.userLatitude,
    this.userLongitude,
    this.isShowDetailBottomModal = true,
    this.focusUserLocationRequestId = 0,
    this.isShowDetailForMarker = false,
    this.selectedProvince = '',
    this.selectedSort = MapSortType.nearest,
    this.isLocationServiceEnabled = false,
  });

  MapState copyWith({
    bool? isLoading,
    bool? hasLocationPermission,
    MapFilterType? selectedFilter,
    String? searchKeyword,
    List<RentalLocation>? locations,
    RentalLocation? selectedLocation,
    int? selectedLocationRequestId,
    double? userLatitude,
    double? userLongitude,
    bool? isShowDetailBottomModal,
    int? focusUserLocationRequestId,
    bool? isShowDetailForMarker,
    String? selectedProvince,
    MapSortType? selectedSort,
    bool? isLocationServiceEnabled,
    String? error,
  }) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      locations: locations ?? this.locations,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedLocationRequestId:
          selectedLocationRequestId ?? this.selectedLocationRequestId,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      isShowDetailBottomModal:
          isShowDetailBottomModal ?? this.isShowDetailBottomModal,
      focusUserLocationRequestId:
          focusUserLocationRequestId ?? this.focusUserLocationRequestId,
      isShowDetailForMarker:isShowDetailForMarker?? this.isShowDetailForMarker ,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedSort: selectedSort ?? this.selectedSort,
      isLocationServiceEnabled: isLocationServiceEnabled ?? this.isLocationServiceEnabled,
      error: error,
    );
  }
}
