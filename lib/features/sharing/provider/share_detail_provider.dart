import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/sharing/mock_share_detail_repository.dart';
import '../../../data/repositories/sharing/share_detail_repository.dart';
import 'share_detail_state.dart';

final shareDetailProvider =
NotifierProvider<ShareDetailProvider, ShareDetailState>(
  ShareDetailProvider.new,
);

class ShareDetailProvider extends Notifier<ShareDetailState> {
  late final ShareDetailRepository _repository;

  @override
  ShareDetailState build() {
    _repository = MockShareDetailRepository();
    return const ShareDetailState();
  }

  Future<void> loadDetail(String locationId) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final detail = await _repository.getShareDetail(locationId);
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

  void updateSelectedSeats(int seats) {
    if (seats < 1) return;
    state = state.copyWith(selectedSeats: seats);
  }

  int getTotalPrice() {
    final detail = state.detail;
    if (detail == null) return 0;
    return detail.pricePerSeat * state.selectedSeats;
  }
}