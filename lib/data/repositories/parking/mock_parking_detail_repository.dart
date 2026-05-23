import '../../models/parking/parking_detail.dart';
import '../../models/parking/parking_feature.dart';
import '../../models/parking/parking_item.dart';
import 'parking_repository.dart';

class MockParkingRepository implements ParkingRepository {
  @override
  Future<ParkingDetail> getParkingDetail(String locationId) async {
    await Future<void>.delayed(const Duration(milliseconds: 220));

    switch (locationId) {
      case 'parking_1':
        return const ParkingDetail(
          id: 'parking_1',
          title: 'Bãi đậu xe Central Hub',
          imageUrl:
              'https://images.unsplash.com/photo-1506521781263-d8422e82f27a?w=1200',
          rating: 4.5,
          reviewCount: 1128,
          distanceLabel: '120m',
          parkingTypeLabel: 'Trong nhà',
          securityLabel: 'An ninh 24/7',
          elevatorLabel: 'Thang máy',
          openingHours: '06:00 - 22:00',
          pricePerHour: 20000,
          pricePerDay: 180000,
          availableSlots: '12 / 50 chỗ',
          paymentMethods: ['VIOPAY', 'Thẻ ATM', 'Tiền mặt'],
          features: [
            ParkingFeature(label: 'Camera 24/7', iconKey: 'camera'),
            ParkingFeature(label: 'Bảo vệ', iconKey: 'security'),
            ParkingFeature(label: 'Ra vào nhanh', iconKey: 'fast'),
          ],
        );
      case 'parking_2':
        return const ParkingDetail(
          id: 'parking_2',
          title: 'Bãi đậu xe Skyline',
          imageUrl:
              'https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?w=1200',
          rating: 4.4,
          reviewCount: 268,
          distanceLabel: '250m',
          parkingTypeLabel: 'Ngoài trời',
          securityLabel: 'An ninh 24/7',
          elevatorLabel: 'Không có',
          openingHours: '24/7',
          pricePerHour: 25000,
          pricePerDay: 220000,
          availableSlots: '8 / 32 chỗ',
          paymentMethods: ['VIOPAY', 'Tiền mặt'],
          features: [
            ParkingFeature(label: 'Camera 24/7', iconKey: 'camera'),
            ParkingFeature(label: 'Có mái che', iconKey: 'roof'),
            ParkingFeature(label: 'Ra vào nhanh', iconKey: 'fast'),
          ],
        );
      case 'parking_3':
        return const ParkingDetail(
          id: 'parking_3',
          title: 'Bãi đậu xe Vincom Plaza',
          imageUrl:
              'https://images.unsplash.com/photo-1590674899484-d5640e854abe?w=1200',
          rating: 4.6,
          reviewCount: 502,
          distanceLabel: '1.8km',
          parkingTypeLabel: 'Trong nhà',
          securityLabel: 'Bảo vệ nhiều lớp',
          elevatorLabel: 'Thang máy',
          openingHours: '24/7',
          pricePerHour: 30000,
          pricePerDay: 260000,
          availableSlots: '3 / 40 chỗ',
          paymentMethods: ['Ví điện tử', 'Thẻ ATM', 'Thẻ tín dụng'],
          features: [
            ParkingFeature(label: 'Camera 24/7', iconKey: 'camera'),
            ParkingFeature(label: 'Sạc xe điện', iconKey: 'charge'),
            ParkingFeature(label: 'Có mái che', iconKey: 'roof'),
          ],
        );
      case 'parking_4':
        return const ParkingDetail(
          id: 'parking_4',
          title: 'Bãi đậu xe Biên Hòa Center',
          imageUrl:
              'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=1200',
          rating: 4.3,
          reviewCount: 187,
          distanceLabel: '2.5km',
          parkingTypeLabel: 'Trong nhà',
          securityLabel: 'Bảo vệ 24/7',
          elevatorLabel: 'Có',
          openingHours: '05:30 - 23:00',
          pricePerHour: 18000,
          pricePerDay: 150000,
          availableSlots: '20 / 60 chỗ',
          paymentMethods: ['VIOPAY', 'Tiền mặt'],
          features: [
            ParkingFeature(label: 'Bảo vệ', iconKey: 'security'),
            ParkingFeature(label: 'Ra vào nhanh', iconKey: 'fast'),
            ParkingFeature(label: 'Giữ xe đêm', iconKey: 'night'),
          ],
        );
      case 'parking_5':
        return const ParkingDetail(
          id: 'parking_5',
          title: 'Bãi đậu xe Amata',
          imageUrl:
              'https://images.unsplash.com/photo-1502877338535-766e1452684a?w=1200',
          rating: 4.0,
          reviewCount: 96,
          distanceLabel: '4.2km',
          parkingTypeLabel: 'Ngoài trời',
          securityLabel: 'Bảo vệ ca đêm',
          elevatorLabel: 'Không có',
          openingHours: '24/7',
          pricePerHour: 15000,
          pricePerDay: 120000,
          availableSlots: '0 / 24 chỗ',
          paymentMethods: ['Tiền mặt'],
          features: [
            ParkingFeature(label: 'Giá rẻ', iconKey: 'price'),
            ParkingFeature(label: 'Mở 24/7', iconKey: 'night'),
            ParkingFeature(label: 'Lối vào rộng', iconKey: 'fast'),
          ],
        );
      default:
        throw Exception('Không tìm thấy dữ liệu chi tiết bãi đậu xe');
    }
  }

  @override
  Future<List<ParkingItem>> getNearbyParking() async {
    await Future<void>.delayed(const Duration(milliseconds: 220));

    return const [
      ParkingItem(
        id: 'parking_1',
        name: 'Bãi đậu xe Central Hub',
        distanceText: '120m',
        statusText: 'Còn chỗ',
        priceText: '20.000đ/giờ',
        latitude: 10.939100,
        longitude: 106.879400,
      ),
      ParkingItem(
        id: 'parking_2',
        name: 'Bãi đậu xe Skyline',
        distanceText: '250m',
        statusText: 'Còn chỗ',
        priceText: '25.000đ/giờ',
        latitude: 10.938900,
        longitude: 106.877700,
      ),
      ParkingItem(
        id: 'parking_4',
        name: 'Bãi đậu xe Biên Hòa Center',
        distanceText: '2.5km',
        statusText: 'Còn chỗ',
        priceText: '18.000đ/giờ',
        latitude: 10.957100,
        longitude: 106.842200,
      ),
    ];
  }
}
