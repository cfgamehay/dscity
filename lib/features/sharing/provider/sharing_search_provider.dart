import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/sharing/place_suggestion.dart';
import '../../../data/models/sharing/share_rule.dart';
import '../../../data/models/sharing/share_trip.dart';
import '../../../data/repositories/sharing/mock_sharing_repository.dart';
import '../../../data/repositories/sharing/sharing_repository.dart';
import 'sharing_search_state.dart';

final sharingSearchProvider =
    NotifierProvider<SharingSearchProvider, SharingSearchState>(
  SharingSearchProvider.new,
);

class SharingSearchProvider extends Notifier<SharingSearchState> {
  late final SharingRepository _repository;
  Timer? _searchDebounce;
  List<ShareTrip> _allTrips = const [];

  @override
  SharingSearchState build() {
    _repository = MockSharingRepository();
    ref.onDispose(() {
      _searchDebounce?.cancel();
    });
    return SharingSearchState.initial();
  }

  Future<void> firstLoad() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final popularPlaces = await _repository.getPopularPlaces();
      final recentPlaces = await _repository.getRecentPlaces();
      final suggestedDestinations = await _repository.getSuggestedDestinations(
        state.pickupPlace?.id,
      );
      _allTrips = await _repository.searchTrips();

      state = state.copyWith(
        isLoading: false,
        popularPlaces: popularPlaces,
        recentPlaces: recentPlaces,
        suggestedDestinations: suggestedDestinations,
      );
      _applyTripFilter();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void changeTab(SharingTab tab) {
    state = state.copyWith(activeTab: tab, error: null);
  }

  void updatePickupPlace(PlaceSuggestion place) {
    state = state.copyWith(
      pickupPlace: place,
      placeResults: const [],
      error: null,
    );
    unawaited(_refreshSuggestedDestinations());
  }

  void updateDropoffPlace(PlaceSuggestion place) {
    state = state.copyWith(
      dropoffPlace: place,
      placeResults: const [],
      error: null,
    );
  }

  void updateSharePickupText(String value) {
    state = state.copyWith(sharePickupText: value, error: null);
  }

  void updateShareDropoffText(String value) {
    state = state.copyWith(shareDropoffText: value, error: null);
  }

  void updateSelectedTime(DateTime time) {
    state = state.copyWith(selectedTime: time, error: null);
  }

  void updateShareTime(DateTime time) {
    state = state.copyWith(shareTime: time, error: null);
  }

  void increaseShareSeats() {
    state = state.copyWith(shareSeats: state.shareSeats + 1, error: null);
  }

  void decreaseShareSeats() {
    if (state.shareSeats <= 1) return;
    state = state.copyWith(shareSeats: state.shareSeats - 1, error: null);
  }

  void updateSharePriceText(String value) {
    state = state.copyWith(sharePriceText: value, error: null);
  }

  void updateShareNote(String value) {
    state = state.copyWith(shareNote: value, error: null);
  }

  void toggleShareRule(ShareRule rule) {
    final selected = List<ShareRule>.from(state.selectedRules);
    final existingIndex = selected.indexWhere((item) => item.label == rule.label);

    if (existingIndex >= 0) {
      selected.removeAt(existingIndex);
    } else {
      selected.add(rule);
    }

    state = state.copyWith(selectedRules: selected, error: null);
  }

  void clearPlaceSearch() {
    _searchDebounce?.cancel();
    state = state.copyWith(
      isSearchingPlaces: false,
      placeResults: const [],
    );
  }

  Future<void> _refreshSuggestedDestinations() async {
    final results = await _repository.getSuggestedDestinations(
      state.pickupPlace?.id,
    );
    state = state.copyWith(suggestedDestinations: results);
  }

  void searchPlaces(String keyword) {
    _searchDebounce?.cancel();

    if (keyword.trim().isEmpty) {
      state = state.copyWith(
        isSearchingPlaces: false,
        placeResults: const [],
      );
      return;
    }

    state = state.copyWith(isSearchingPlaces: true);
    _searchDebounce = Timer(const Duration(milliseconds: 280), () async {
      final results = await _repository.searchPlaces(keyword);
      state = state.copyWith(
        isSearchingPlaces: false,
        placeResults: results,
      );
    });
  }

  void changeTripFilter(TripResultFilter filter) {
    state = state.copyWith(tripFilter: filter);
    _applyTripFilter();
  }

  Future<void> searchTrips() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      _allTrips = await _repository.searchTrips(
        pickupSuggestionId: state.pickupPlace?.id,
        dropoffSuggestionId: state.dropoffPlace?.id,
        departureTime: state.selectedTime,
      );

      state = state.copyWith(isLoading: false);
      _applyTripFilter();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> submitShareRide() async {
    final pickup = state.sharePickupText.trim();
    final dropoff = state.shareDropoffText.trim();
    final seats = state.shareSeats;
    final ruleText = state.selectedRules.map((item) => item.label).join(', ');
    final price = int.tryParse(
          state.sharePriceText.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;

    if (pickup.isEmpty || dropoff.isEmpty || seats <= 0 || price <= 0) {
      state = state.copyWith(
        error: 'Vui lòng nhập đủ thông tin chuyến đi.',
      );
      return false;
    }

    state = state.copyWith(isSubmittingShareRide: true, error: null);

    try {
      await _repository.createTrip(
        pickupLabel: pickup,
        dropoffLabel: dropoff,
        departureTime: state.shareTime,
        availableSeats: seats,
        pricePerSeat: price,
        note: _composeShareNote(
          note: state.shareNote.trim(),
          ruleText: ruleText,
        ),
      );

      _allTrips = await _repository.searchTrips();
      state = state.copyWith(
        isSubmittingShareRide: false,
        activeTab: SharingTab.findTrip,
        sharePickupText: '',
        shareDropoffText: '',
        shareSeats: 2,
        sharePriceText: '',
        shareNote: '',
        selectedRules: const [],
      );
      _applyTripFilter();
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmittingShareRide: false,
        error: e.toString(),
      );
      return false;
    }
  }

  void _applyTripFilter() {
    final list = List<ShareTrip>.from(_allTrips);

    switch (state.tripFilter) {
      case TripResultFilter.all:
        break;
      case TripResultFilter.cheapest:
        list.sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
        break;
      case TripResultFilter.available:
        list.sort((a, b) => b.availableSeats.compareTo(a.availableSeats));
        break;
      case TripResultFilter.earliest:
        list.sort((a, b) => a.departureLabel.compareTo(b.departureLabel));
        break;
    }

    state = state.copyWith(trips: list);
  }

  String _composeShareNote({
    required String note,
    required String ruleText,
  }) {
    if (ruleText.isEmpty) {
      return note;
    }

    if (note.isEmpty) {
      return 'Nội quy: $ruleText';
    }

    return '$note\n\nNội quy: $ruleText';
  }
}
