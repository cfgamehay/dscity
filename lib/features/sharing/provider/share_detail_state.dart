import '../../../data/models/sharing/share_detail.dart';

class ShareDetailState {
  final bool isLoading;
  final ShareDetail? detail;
  final String? error;
  final int selectedSeats;

  const ShareDetailState({
    this.isLoading = false,
    this.detail,
    this.error,
    this.selectedSeats = 1,
  });

  ShareDetailState copyWith({
    bool? isLoading,
    ShareDetail? detail,
    String? error,
    int? selectedSeats,
  }) {
    return ShareDetailState(
      isLoading: isLoading ?? this.isLoading,
      detail: detail ?? this.detail,
      error: error,
      selectedSeats: selectedSeats ?? this.selectedSeats,
    );
  }
}