import '../../models/parking/parking_detail.dart';
import '../../models/parking/parking_item.dart';

abstract class ParkingRepository {
  Future<ParkingDetail> getParkingDetail(String locationId);
  Future<List<ParkingItem>> getNearbyParking();

}