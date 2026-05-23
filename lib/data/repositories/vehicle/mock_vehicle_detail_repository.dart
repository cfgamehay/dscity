import '../../models/vehicle/vehicle_detail.dart';
import '../../models/vehicle/vehicle_feature.dart';
import 'vehicle_detail_repository.dart';

class MockVehicleDetailRepository implements VehicleDetailRepository {
  @override
  Future<VehicleDetail> getVehicleDetail(String locationId) async {
    await Future<void>.delayed(const Duration(milliseconds: 220));

    switch (locationId) {
      case 'car_1':
        return const VehicleDetail(
          id: 'car_1',
          title: 'Toyota Vios 2023',
          imageUrl:
              'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=1200',
          transmissionLabel: 'Tự động',
          specLabel: '5 chỗ',
          fuelLabel: 'Xăng',
          rating: 4.8,
          reviewCount: 256,
          basePriceLabel: '120.000đ/giờ',
          pricePerHour: '120.000đ/giờ',
          pricePerDay: '1.050.000đ/ngày',
          pricePerWeek: '6.200.000đ/tuần',
          features: [
            VehicleFeature(label: 'Bảo hiểm đầy đủ', iconKey: 'insurance'),
            VehicleFeature(label: 'Giao xe tận nơi', iconKey: 'delivery'),
            VehicleFeature(label: 'Hỗ trợ 24/7', iconKey: 'support'),
          ],
          buttonText: 'Tiếp tục đặt xe',
        );
      case 'car_2':
        return const VehicleDetail(
          id: 'car_2',
          title: 'Kia Seltos Premium',
          imageUrl:
              'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=1200',
          transmissionLabel: 'Tự động',
          specLabel: '5 chỗ',
          fuelLabel: 'Xăng',
          rating: 4.9,
          reviewCount: 182,
          basePriceLabel: '180.000đ/giờ',
          pricePerHour: '180.000đ/giờ',
          pricePerDay: '1.350.000đ/ngày',
          pricePerWeek: '8.400.000đ/tuần',
          features: [
            VehicleFeature(label: 'Cam 360', iconKey: 'camera'),
            VehicleFeature(label: 'Giao xe tận nơi', iconKey: 'delivery'),
            VehicleFeature(label: 'Đi liên tỉnh', iconKey: 'route'),
          ],
          buttonText: 'Tiếp tục đặt xe',
        );
      case 'car_3':
        return const VehicleDetail(
          id: 'car_3',
          title: 'Hyundai Accent',
          imageUrl:
              'https://images.unsplash.com/photo-1550355291-bbee04a92027?w=1200',
          transmissionLabel: 'Tự động',
          specLabel: '5 chỗ',
          fuelLabel: 'Xăng',
          rating: 4.6,
          reviewCount: 94,
          basePriceLabel: '110.000đ/giờ',
          pricePerHour: '110.000đ/giờ',
          pricePerDay: '980.000đ/ngày',
          pricePerWeek: '5.900.000đ/tuần',
          features: [
            VehicleFeature(label: 'Tiết kiệm nhiên liệu', iconKey: 'fuel'),
            VehicleFeature(label: 'Nhận xe nhanh', iconKey: 'fast'),
            VehicleFeature(label: 'Hỗ trợ 24/7', iconKey: 'support'),
          ],
          buttonText: 'Tiếp tục đặt xe',
        );
      case 'motorbike_1':
        return const VehicleDetail(
          id: 'motorbike_1',
          title: 'Honda Vision 2024',
          imageUrl:
              'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=1200',
          transmissionLabel: 'Tự động',
          specLabel: '110cc',
          fuelLabel: 'Xăng',
          rating: 4.7,
          reviewCount: 1984,
          basePriceLabel: '15.000đ/giờ',
          pricePerHour: '15.000đ/giờ',
          pricePerDay: '120.000đ/ngày',
          pricePerWeek: '700.000đ/tuần',
          features: [
            VehicleFeature(label: '2 mũ bảo hiểm', iconKey: 'helmet'),
            VehicleFeature(label: 'Giao xe tận nơi', iconKey: 'delivery'),
            VehicleFeature(label: 'Hỗ trợ 24/7', iconKey: 'support'),
          ],
          buttonText: 'Tiếp tục đặt xe',
        );
      case 'motorbike_2':
        return const VehicleDetail(
          id: 'motorbike_2',
          title: 'Yamaha Janus',
          imageUrl:
              'https://images.unsplash.com/photo-1624349735079-f0b6f6c7f671?w=1200',
          transmissionLabel: 'Tự động',
          specLabel: '125cc',
          fuelLabel: 'Xăng',
          rating: 4.5,
          reviewCount: 438,
          basePriceLabel: '18.000đ/giờ',
          pricePerHour: '18.000đ/giờ',
          pricePerDay: '135.000đ/ngày',
          pricePerWeek: '820.000đ/tuần',
          features: [
            VehicleFeature(label: 'Cốp rộng', iconKey: 'storage'),
            VehicleFeature(label: 'Giao xe tận nơi', iconKey: 'delivery'),
            VehicleFeature(label: 'Nhận xe nhanh', iconKey: 'fast'),
          ],
          buttonText: 'Tiếp tục đặt xe',
        );
      case 'motorbike_3':
        return const VehicleDetail(
          id: 'motorbike_3',
          title: 'Honda Wave RSX',
          imageUrl:
              'https://images.unsplash.com/photo-1609630875171-b1321377ee65?w=1200',
          transmissionLabel: 'Số',
          specLabel: '110cc',
          fuelLabel: 'Xăng',
          rating: 4.4,
          reviewCount: 152,
          basePriceLabel: '12.000đ/giờ',
          pricePerHour: '12.000đ/giờ',
          pricePerDay: '95.000đ/ngày',
          pricePerWeek: '560.000đ/tuần',
          features: [
            VehicleFeature(label: 'Tiết kiệm xăng', iconKey: 'fuel'),
            VehicleFeature(label: 'Xe khỏe', iconKey: 'engine'),
            VehicleFeature(label: 'Nhận xe nhanh', iconKey: 'fast'),
          ],
          buttonText: 'Tiếp tục đặt xe',
        );
      default:
        throw Exception('Không tìm thấy dữ liệu chi tiết phương tiện');
    }
  }
}
