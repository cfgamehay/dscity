import 'package:dscity_mobile_app/core/constants/constants.dart';
import '../../../data/model/map/rental_location.dart';

class MapState {
  final bool isLoading;
  final bool hasLocationPermission;
  final double? userLatitude;
  final double? userLongitude;
  final MapFilterType selectedFilter;
  final String searchKeyword;
  final List<RentalLocation> locations;
  final RentalLocation? selectedLocation;
  final bool isShowDetailBottomModal;
  final bool isShowDetailForMarker;
  final int focusUserLocationRequestId;
  final String? error;

  const MapState({
    this.isLoading = false,
    this.hasLocationPermission = false,
    this.selectedFilter = MapFilterType.parking,
    this.searchKeyword = '',
    this.locations = const [],
    this.selectedLocation,
    this.error,
    this.userLatitude,
    this.userLongitude,
    this.isShowDetailBottomModal = true,
    this.focusUserLocationRequestId = 0,
    this.isShowDetailForMarker = false,
  });

  MapState copyWith({
    bool? isLoading,
    bool? hasLocationPermission,
    MapFilterType? selectedFilter,
    String? searchKeyword,
    List<RentalLocation>? locations,
    RentalLocation? selectedLocation,
    double? userLatitude,
    double? userLongitude,
    bool? isShowDetailBottomModal,
    int? focusUserLocationRequestId,
    bool? isShowDetailForMarker,
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
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      isShowDetailBottomModal:
          isShowDetailBottomModal ?? this.isShowDetailBottomModal,
      focusUserLocationRequestId:
          focusUserLocationRequestId ?? this.focusUserLocationRequestId,
      isShowDetailForMarker:isShowDetailForMarker?? this.isShowDetailForMarker ,
      error: error,
    );
  }
}
