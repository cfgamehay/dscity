import '../../../data/models/map/rental_location.dart';

enum ParkingTypeFilter {
  all,
  indoor,
  outdoor,
}

enum ParkingSortType {
  nearest,
  cheapest,
}

class ParkingListingState {
  final bool isLoading;
  final bool hasLocationPermission;
  final bool isLocationServiceEnabled;
  final String searchKeyword;
  final String selectedProvince;
  final double? userLatitude;
  final double? userLongitude;
  final List<RentalLocation> allItems;
  final List<RentalLocation> filteredItems;
  final ParkingTypeFilter typeFilter;
  final bool onlyAvailable;
  final bool onlyOpen24h;
  final ParkingSortType sortType;
  final String? error;

  const ParkingListingState({
    this.isLoading = false,
    this.hasLocationPermission = false,
    this.isLocationServiceEnabled = false,
    this.searchKeyword = '',
    this.selectedProvince = '',
    this.userLatitude,
    this.userLongitude,
    this.allItems = const [],
    this.filteredItems = const [],
    this.typeFilter = ParkingTypeFilter.all,
    this.onlyAvailable = false,
    this.onlyOpen24h = false,
    this.sortType = ParkingSortType.nearest,
    this.error,
  });

  ParkingListingState copyWith({
    bool? isLoading,
    bool? hasLocationPermission,
    bool? isLocationServiceEnabled,
    String? searchKeyword,
    String? selectedProvince,
    double? userLatitude,
    double? userLongitude,
    List<RentalLocation>? allItems,
    List<RentalLocation>? filteredItems,
    ParkingTypeFilter? typeFilter,
    bool? onlyAvailable,
    bool? onlyOpen24h,
    ParkingSortType? sortType,
    String? error,
  }) {
    return ParkingListingState(
      isLoading: isLoading ?? this.isLoading,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      isLocationServiceEnabled:
          isLocationServiceEnabled ?? this.isLocationServiceEnabled,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      typeFilter: typeFilter ?? this.typeFilter,
      onlyAvailable: onlyAvailable ?? this.onlyAvailable,
      onlyOpen24h: onlyOpen24h ?? this.onlyOpen24h,
      sortType: sortType ?? this.sortType,
      error: error,
    );
  }
}
