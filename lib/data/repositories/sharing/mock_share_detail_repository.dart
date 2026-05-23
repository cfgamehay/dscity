import '../../models/sharing/share_detail.dart';
import '../../models/sharing/share_rule.dart';
import '../../models/sharing/share_stop_point.dart';
import 'share_detail_repository.dart';

class MockShareDetailRepository implements ShareDetailRepository {
  @override
  Future<ShareDetail> getShareDetail(String locationId) async {
    await Future<void>.delayed(const Duration(milliseconds: 220));

    switch (locationId) {
      case '5':
        return const ShareDetail(
          id: '5',
          routeTitle: 'KTX khu A -> Vincom Thủ Đức',
          departureTime: 'Hôm nay, 09:00',
          durationLabel: '25 phút',
          pricePerSeat: 40000,
          availableSeats: 2,
          driverName: 'Minh Đức',
          driverRating: 4.9,
          completedTrips: 45,
          vehicleName: 'Toyota Vios 2022',
          vehiclePlate: '51H-123.45',
          vehicleColor: 'Trắng',
          stopPoints: [
            ShareStopPoint(
              title: 'Điểm đón',
              subtitle: 'Cổng KTX khu A',
              isPickup: true,
            ),
            ShareStopPoint(
              title: 'Điểm trả',
              subtitle: 'Vincom Thủ Đức',
              isPickup: false,
            ),
          ],
          rules: [
            ShareRule(label: 'Không hút thuốc', iconKey: 'nosmoke'),
            ShareRule(label: 'Không thú cưng', iconKey: 'nopet'),
            ShareRule(label: 'Ưu tiên đúng giờ', iconKey: 'time'),
          ],
          note:
              'Mình xuất phát đúng giờ, có thể hỗ trợ đón lệch một đoạn ngắn quanh điểm hẹn nếu báo trước.',
          buttonText: 'Tham gia chuyến',
        );
      case '6':
        return const ShareDetail(
          id: '6',
          routeTitle: 'Đại học Quốc gia -> Suối Tiên',
          departureTime: 'Hôm nay, 10:30',
          durationLabel: '20 phút',
          pricePerSeat: 50000,
          availableSeats: 1,
          driverName: 'Thanh Hằng',
          driverRating: 4.8,
          completedTrips: 31,
          vehicleName: 'Honda City 2021',
          vehiclePlate: '60A-456.78',
          vehicleColor: 'Đỏ',
          stopPoints: [
            ShareStopPoint(
              title: 'Điểm đón',
              subtitle: 'Cổng ĐHQG khu A',
              isPickup: true,
            ),
            ShareStopPoint(
              title: 'Điểm trả',
              subtitle: 'Bến xe Suối Tiên',
              isPickup: false,
            ),
          ],
          rules: [
            ShareRule(label: 'Không hút thuốc', iconKey: 'nosmoke'),
            ShareRule(label: 'Hành lý gọn nhẹ', iconKey: 'bag'),
            ShareRule(label: 'Có thể gọi xác nhận', iconKey: 'phone'),
          ],
          note:
              'Ưu tiên khách đi đúng giờ, có thể chờ tối đa 5 phút tại điểm hẹn.',
          buttonText: 'Tham gia chuyến',
        );
      case '7':
        return const ShareDetail(
          id: '7',
          routeTitle: 'Thủ Đức -> Dĩ An',
          departureTime: 'Hôm nay, 11:15',
          durationLabel: '18 phút',
          pricePerSeat: 30000,
          availableSeats: 3,
          driverName: 'Quốc Anh',
          driverRating: 4.9,
          completedTrips: 62,
          vehicleName: 'Mazda 3 2020',
          vehiclePlate: '61A-234.56',
          vehicleColor: 'Xanh đậm',
          stopPoints: [
            ShareStopPoint(
              title: 'Điểm đón',
              subtitle: 'Vincom Thủ Đức',
              isPickup: true,
            ),
            ShareStopPoint(
              title: 'Điểm trả',
              subtitle: 'Đại học Bách Khoa',
              isPickup: false,
            ),
          ],
          rules: [
            ShareRule(label: 'Không hút thuốc', iconKey: 'nosmoke'),
            ShareRule(label: 'Không mở nhạc lớn', iconKey: 'music'),
            ShareRule(label: 'Ưu tiên đúng giờ', iconKey: 'time'),
          ],
          note:
              'Nếu bạn ở gần lộ trình chính mình có thể đón thêm trong phạm vi 500m.',
          buttonText: 'Tham gia chuyến',
        );
      default:
        throw Exception('Không tìm thấy dữ liệu chuyến đi');
    }
  }
}
