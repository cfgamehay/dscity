import 'package:dscity_mobile_app/features/map/provider/map_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/enum.dart';
import '../../../core/services/location_services.dart';
import '../../../data/model/map/rental_location.dart';

final mapProvider = NotifierProvider<MapProvider, MapState>(
  MapProvider.new
);

class MapProvider extends Notifier<MapState>{
  static const _allLocations = <RentalLocation>[
    RentalLocation(
      id: '1',
      name: 'Bãi đậu xe Central Hub',
      latitude: 10.939100,
      longitude: 106.879400,
      type: MapFilterType.parking,
      distanceText: '120m',
      statusText: 'Còn chỗ',
      priceText: '20.000/giờ',
    ),
    RentalLocation(
      id: '2',
      name: 'Thuê xe máy B',
      latitude: 10.937800,
      longitude: 106.878200,
      type: MapFilterType.motorbike,
      distanceText: '180m',
      statusText: 'Còn chỗ',
      priceText: '15.000/giờ',
    ),
    RentalLocation(
      id: '3',
      name: 'Bãi đậu xe Skyline',
      latitude: 10.938900,
      longitude: 106.877700,
      type: MapFilterType.parking,
      distanceText: '250m',
      statusText: 'Còn chỗ',
      priceText: '25.000/giờ',
    ),
    RentalLocation(
      id: '4',
      name: 'Thuê ô tô A',
      latitude: 10.940000,
      longitude: 106.879100,
      type: MapFilterType.car,
      distanceText: '300m',
      statusText: 'Còn xe',
      priceText: '120.000/giờ',
    ),
    RentalLocation(
      id: '5',
      name: 'Điểm chia sẻ phương tiện',
      latitude: 10.937300,
      longitude: 106.879500,
      type: MapFilterType.sharing,
      distanceText: '350m',
      statusText: 'Khả dụng',
      priceText: 'Miễn phí',
    ),
  ];
  @override
  MapState build() {
    return const MapState();
  }

  Future<void> _loadUserLocation() async {
    final position = await LocationService.getCurrentPosition();

    if (position == null) {
      state = state.copyWith(hasLocationPermission: false);
      return;
    }

    state = state.copyWith(
      hasLocationPermission: true,
      userLatitude: position.latitude,
      userLongitude: position.longitude,
    );
  }

  Future<void> firstLoad() async {
    state = state.copyWith(isLoading: true);
    await _loadUserLocation();
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _applyFilter(state.selectedFilter);
    state = state.copyWith(isLoading: false);
  }

  void changeFilter(MapFilterType filter) {
    state = state.copyWith(selectedFilter: filter);
    _applyFilter(filter);
  }

  void selectLocation(RentalLocation location) {
    state = state.copyWith(selectedLocation: location, isShowDetailForMarker: true);
  }

  void _applyFilter(MapFilterType filter) {
    final filtered = _allLocations.where((e) => e.type == filter).toList();
    state = state.copyWith(locations: filtered);
  }

  void requestFocusUserLocation()
  {
    state = state.copyWith(
      focusUserLocationRequestId: state.focusUserLocationRequestId + 1,
    );
    unselectedLocation();
  }

  void toggleBottomModal()
  {
    state = state.copyWith(isShowDetailBottomModal: !state.isShowDetailBottomModal);
  }

  void  unselectedLocation()
  {
    state = state.copyWith(isShowDetailForMarker: false);
  }


}