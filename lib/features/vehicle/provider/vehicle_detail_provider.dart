import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/vehicle/mock_vehicle_detail_repository.dart';
import '../../../data/repositories/vehicle/vehicle_detail_repository.dart';
import 'vehicle_detail_state.dart';

final vehicleDetailProvider =
NotifierProvider<VehicleDetailProvider, VehicleDetailState>(
  VehicleDetailProvider.new,
);

class VehicleDetailProvider extends Notifier<VehicleDetailState> {
  late final VehicleDetailRepository _repository;

  @override
  VehicleDetailState build() {
    _repository = MockVehicleDetailRepository();
    return const VehicleDetailState();
  }

  Future<void> loadDetail(String locationId) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final detail = await _repository.getVehicleDetail(locationId);

      state = state.copyWith(
        isLoading: false,
        detail: detail,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void selectPriceOption(VehiclePriceOption option) {
    state = state.copyWith(
      selectedPriceOption: option,
    );
  }
}