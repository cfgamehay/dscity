import '../../../data/models/vehicle/vehicle_detail.dart';

enum VehiclePriceOption {
  hour,
  day,
  week,
}

class VehicleDetailState {
  final bool isLoading;
  final VehicleDetail? detail;
  final String? error;
  final VehiclePriceOption selectedPriceOption;

  const VehicleDetailState({
    this.isLoading = false,
    this.detail,
    this.error,
    this.selectedPriceOption = VehiclePriceOption.day,
  });

  VehicleDetailState copyWith({
    bool? isLoading,
    VehicleDetail? detail,
    String? error,
    VehiclePriceOption? selectedPriceOption,
  }) {
    return VehicleDetailState(
      isLoading: isLoading ?? this.isLoading,
      detail: detail ?? this.detail,
      error: error,
      selectedPriceOption: selectedPriceOption ?? this.selectedPriceOption,
    );
  }
}