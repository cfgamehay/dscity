import '../../models/sharing/place_suggestion.dart';
import '../../models/sharing/share_trip.dart';

abstract class SharingRepository {
  Future<List<PlaceSuggestion>> getPopularPlaces();
  Future<List<PlaceSuggestion>> getRecentPlaces();
  Future<List<PlaceSuggestion>> searchPlaces(String keyword);
  Future<List<PlaceSuggestion>> getSuggestedDestinations(String? fromPlaceId);
  Future<List<ShareTrip>> searchTrips({
    String? pickupSuggestionId,
    String? dropoffSuggestionId,
    DateTime? departureTime,
  });
  Future<void> createTrip({
    required String pickupLabel,
    required String dropoffLabel,
    required DateTime departureTime,
    required int availableSeats,
    required int pricePerSeat,
    required String note,
  });
}
