import '../../models/sharing/place_suggestion.dart';
import '../../models/sharing/share_trip.dart';
import 'sharing_repository.dart';

class MockSharingRepository implements SharingRepository {
  static const _places = <PlaceSuggestion>[
    PlaceSuggestion(
      id: 'current_location',
      title: 'Vị trí hiện tại',
      subtitle: 'Gần bạn',
      keywords: ['current', 'gan day', 'hien tai'],
      isCurrentLocation: true,
    ),
    PlaceSuggestion(
      id: 'ktx_a',
      title: 'KTX khu A',
      subtitle: 'Linh Trung, Thủ Đức',
      keywords: ['ktx', 'khu a', 'linh trung', 'thu duc'],
      isPopular: true,
      isRecent: true,
    ),
    PlaceSuggestion(
      id: 'vincom_td',
      title: 'Vincom Thủ Đức',
      subtitle: 'Võ Văn Ngân, Thủ Đức',
      keywords: ['vincom', 'vo van ngan', 'thu duc'],
      isPopular: true,
      isRecent: true,
    ),
    PlaceSuggestion(
      id: 'dhbk',
      title: 'Đại học Bách Khoa',
      subtitle: 'Đông Hòa, Dĩ An',
      keywords: ['bach khoa', 'dhbk', 'di an'],
      isPopular: true,
    ),
    PlaceSuggestion(
      id: 'dhqg',
      title: 'Đại học Quốc gia',
      subtitle: 'Linh Trung, Thủ Đức',
      keywords: ['dhqg', 'quoc gia', 'linh trung'],
      isRecent: true,
    ),
    PlaceSuggestion(
      id: 'suoitien',
      title: 'Bến xe Suối Tiên',
      subtitle: 'Xa lộ Hà Nội, Thủ Đức',
      keywords: ['suoi tien', 'ben xe', 'thu duc'],
      isPopular: true,
    ),
  ];

  static final List<ShareTrip> _trips = <ShareTrip>[
    const ShareTrip(
      id: '5',
      driverName: 'Minh Đức',
      rating: 4.8,
      fromLabel: 'Q.1',
      toLabel: 'Q.7',
      departureLabel: 'Hôm nay, 09:00',
      pricePerSeat: 40000,
      availableSeats: 2,
      pickupId: 'ktx_a',
      dropoffId: 'vincom_td',
    ),
    const ShareTrip(
      id: '6',
      driverName: 'Thanh Hằng',
      rating: 4.8,
      fromLabel: 'Q.10',
      toLabel: 'Q.2',
      departureLabel: 'Hôm nay, 10:30',
      pricePerSeat: 50000,
      availableSeats: 1,
      pickupId: 'dhqg',
      dropoffId: 'suoitien',
    ),
    const ShareTrip(
      id: '7',
      driverName: 'Quốc Anh',
      rating: 4.9,
      fromLabel: 'Thủ Đức',
      toLabel: 'Dĩ An',
      departureLabel: 'Hôm nay, 11:15',
      pricePerSeat: 30000,
      availableSeats: 3,
      pickupId: 'vincom_td',
      dropoffId: 'dhbk',
    ),
  ];

  @override
  Future<List<PlaceSuggestion>> getPopularPlaces() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return _places.where((item) => item.isPopular).toList();
  }

  @override
  Future<List<PlaceSuggestion>> getRecentPlaces() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return _places.where((item) => item.isRecent).toList();
  }

  @override
  Future<List<PlaceSuggestion>> searchPlaces(String keyword) async {
    await Future<void>.delayed(const Duration(milliseconds: 140));
    return _places.where((item) => item.matchesKeyword(keyword)).toList();
  }

  @override
  Future<List<PlaceSuggestion>> getSuggestedDestinations(
    String? fromPlaceId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));

    if (fromPlaceId == 'ktx_a') {
      return _places
          .where((item) => ['vincom_td', 'dhbk', 'suoitien'].contains(item.id))
          .toList();
    }

    if (fromPlaceId == 'vincom_td') {
      return _places
          .where((item) => ['ktx_a', 'dhqg', 'suoitien'].contains(item.id))
          .toList();
    }

    return _places.where((item) => item.isPopular).toList();
  }

  @override
  Future<List<ShareTrip>> searchTrips({
    String? pickupSuggestionId,
    String? dropoffSuggestionId,
    DateTime? departureTime,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 180));

    Iterable<ShareTrip> result = _trips;

    if (pickupSuggestionId != null && pickupSuggestionId.isNotEmpty) {
      result = result.where(
        (item) => item.pickupId == pickupSuggestionId,
      );
    }

    if (dropoffSuggestionId != null && dropoffSuggestionId.isNotEmpty) {
      result = result.where(
        (item) => item.dropoffId == dropoffSuggestionId,
      );
    }

    final trips = result.toList();
    return trips.isEmpty ? List<ShareTrip>.from(_trips) : trips;
  }

  @override
  Future<void> createTrip({
    required String pickupLabel,
    required String dropoffLabel,
    required DateTime departureTime,
    required int availableSeats,
    required int pricePerSeat,
    required String note,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 240));

    _trips.insert(
      0,
      ShareTrip(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        driverName: 'Bạn',
        rating: 5.0,
        fromLabel: pickupLabel,
        toLabel: dropoffLabel,
        departureLabel:
            'Hôm nay, ${departureTime.hour.toString().padLeft(2, '0')}:${departureTime.minute.toString().padLeft(2, '0')}',
        pricePerSeat: pricePerSeat,
        availableSeats: availableSeats,
        pickupId: pickupLabel,
        dropoffId: dropoffLabel,
      ),
    );
  }
}
