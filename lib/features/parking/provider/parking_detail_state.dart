import '../../../data/models/parking/parking_detail.dart';

enum ParkingPriceOption {
  hour,
  day,
  week,
}

class ParkingDetailState {
  final bool isLoading;
  final ParkingDetail? detail;
  final String? error;
  final ParkingPriceOption selectedPriceOption;

  const ParkingDetailState({
    this.isLoading = false,
    this.detail,
    this.error,
    this.selectedPriceOption = ParkingPriceOption.hour,
  });

  ParkingDetailState copyWith({
    bool? isLoading,
    ParkingDetail? detail,
    String? error,
    ParkingPriceOption? selectedPriceOption,
  }) {
    return ParkingDetailState(
      isLoading: isLoading ?? this.isLoading,
      detail: detail ?? this.detail,
      error: error,
      selectedPriceOption: selectedPriceOption ?? this.selectedPriceOption,
    );
  }
}