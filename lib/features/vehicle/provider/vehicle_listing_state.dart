import '../../../core/constants/enum.dart';
import '../../../data/models/map/rental_location.dart';

enum VehicleSortType {
  nearest,
  cheapest,
}

class VehicleListingState {
  final bool isLoading;
  final bool hasLocationPermission;
  final bool isLocationServiceEnabled;
  final String searchKeyword;
  final String selectedProvince;
  final double? userLatitude;
  final double? userLongitude;
  final MapFilterType vehicleType;
  final List<RentalLocation> allItems;
  final List<RentalLocation> filteredItems;
  final bool onlyAvailable;
  final VehicleSortType sortType;
  final String? error;

  const VehicleListingState({
    this.isLoading = false,
    this.hasLocationPermission = false,
    this.isLocationServiceEnabled = false,
    this.searchKeyword = '',
    this.selectedProvince = '',
    this.userLatitude,
    this.userLongitude,
    this.vehicleType = MapFilterType.car,
    this.allItems = const [],
    this.filteredItems = const [],
    this.onlyAvailable = false,
    this.sortType = VehicleSortType.nearest,
    this.error,
  });

  VehicleListingState copyWith({
    bool? isLoading,
    bool? hasLocationPermission,
    bool? isLocationServiceEnabled,
    String? searchKeyword,
    String? selectedProvince,
    double? userLatitude,
    double? userLongitude,
    MapFilterType? vehicleType,
    List<RentalLocation>? allItems,
    List<RentalLocation>? filteredItems,
    bool? onlyAvailable,
    VehicleSortType? sortType,
    String? error,
  }) {
    return VehicleListingState(
      isLoading: isLoading ?? this.isLoading,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      isLocationServiceEnabled:
          isLocationServiceEnabled ?? this.isLocationServiceEnabled,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      vehicleType: vehicleType ?? this.vehicleType,
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      onlyAvailable: onlyAvailable ?? this.onlyAvailable,
      sortType: sortType ?? this.sortType,
      error: error,
    );
  }
}
