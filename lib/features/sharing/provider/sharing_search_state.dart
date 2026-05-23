import '../../../data/models/sharing/place_suggestion.dart';
import '../../../data/models/sharing/share_trip.dart';

enum SharingTab {
  findTrip,
  shareRide,
}

enum TripResultFilter {
  all,
  cheapest,
  available,
  earliest,
}

class SharingSearchState {
  final bool isLoading;
  final bool isSearchingPlaces;
  final bool isSubmittingShareRide;
  final SharingTab activeTab;
  final TripResultFilter tripFilter;
  final PlaceSuggestion? pickupPlace;
  final PlaceSuggestion? dropoffPlace;
  final DateTime selectedTime;
  final String sharePickupText;
  final String shareDropoffText;
  final DateTime shareTime;
  final int shareSeats;
  final String sharePriceText;
  final String shareNote;
  final List<PlaceSuggestion> popularPlaces;
  final List<PlaceSuggestion> recentPlaces;
  final List<PlaceSuggestion> suggestedDestinations;
  final List<PlaceSuggestion> placeResults;
  final List<ShareTrip> trips;
  final String? error;

  const SharingSearchState({
    this.isLoading = false,
    this.isSearchingPlaces = false,
    this.isSubmittingShareRide = false,
    this.activeTab = SharingTab.findTrip,
    this.tripFilter = TripResultFilter.all,
    this.pickupPlace,
    this.dropoffPlace,
    required this.selectedTime,
    this.sharePickupText = '',
    this.shareDropoffText = '',
    required this.shareTime,
    this.shareSeats = 2,
    this.sharePriceText = '',
    this.shareNote = '',
    this.popularPlaces = const [],
    this.recentPlaces = const [],
    this.suggestedDestinations = const [],
    this.placeResults = const [],
    this.trips = const [],
    this.error,
  });

  factory SharingSearchState.initial() {
    final now = DateTime.now();
    return SharingSearchState(
      selectedTime: now.copyWith(hour: 9, minute: 0),
      shareTime: now.copyWith(hour: 9, minute: 0),
    );
  }

  SharingSearchState copyWith({
    bool? isLoading,
    bool? isSearchingPlaces,
    bool? isSubmittingShareRide,
    SharingTab? activeTab,
    TripResultFilter? tripFilter,
    PlaceSuggestion? pickupPlace,
    bool clearPickupPlace = false,
    PlaceSuggestion? dropoffPlace,
    bool clearDropoffPlace = false,
    DateTime? selectedTime,
    String? sharePickupText,
    String? shareDropoffText,
    DateTime? shareTime,
    int? shareSeats,
    String? sharePriceText,
    String? shareNote,
    List<PlaceSuggestion>? popularPlaces,
    List<PlaceSuggestion>? recentPlaces,
    List<PlaceSuggestion>? suggestedDestinations,
    List<PlaceSuggestion>? placeResults,
    List<ShareTrip>? trips,
    String? error,
  }) {
    return SharingSearchState(
      isLoading: isLoading ?? this.isLoading,
      isSearchingPlaces: isSearchingPlaces ?? this.isSearchingPlaces,
      isSubmittingShareRide:
          isSubmittingShareRide ?? this.isSubmittingShareRide,
      activeTab: activeTab ?? this.activeTab,
      tripFilter: tripFilter ?? this.tripFilter,
      pickupPlace: clearPickupPlace ? null : pickupPlace ?? this.pickupPlace,
      dropoffPlace:
          clearDropoffPlace ? null : dropoffPlace ?? this.dropoffPlace,
      selectedTime: selectedTime ?? this.selectedTime,
      sharePickupText: sharePickupText ?? this.sharePickupText,
      shareDropoffText: shareDropoffText ?? this.shareDropoffText,
      shareTime: shareTime ?? this.shareTime,
      shareSeats: shareSeats ?? this.shareSeats,
      sharePriceText: sharePriceText ?? this.sharePriceText,
      shareNote: shareNote ?? this.shareNote,
      popularPlaces: popularPlaces ?? this.popularPlaces,
      recentPlaces: recentPlaces ?? this.recentPlaces,
      suggestedDestinations:
          suggestedDestinations ?? this.suggestedDestinations,
      placeResults: placeResults ?? this.placeResults,
      trips: trips ?? this.trips,
      error: error,
    );
  }
}
