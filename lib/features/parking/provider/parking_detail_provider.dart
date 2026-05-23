import 'package:dscity_mobile_app/features/parking/provider/parking_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/parking/mock_parking_detail_repository.dart';
import '../../../data/repositories/parking/parking_repository.dart';


final parkingDetailProvider =
NotifierProvider<ParkingDetailProvider, ParkingDetailState>(
  ParkingDetailProvider.new,
);

class ParkingDetailProvider extends Notifier<ParkingDetailState> {
  late final ParkingRepository _repository;

  @override
  ParkingDetailState build() {
    _repository = MockParkingRepository();
    return const ParkingDetailState();
  }

  Future<void> loadDetail(String locationId) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final detail = await _repository.getParkingDetail(locationId);

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

  void selectPriceOption(ParkingPriceOption option) {
    state = state.copyWith(
      selectedPriceOption: option,
    );
  }
}