import '../../../../data/models/vehicle/vehicle_detail.dart';

abstract class VehicleDetailRepository {
  Future<VehicleDetail> getVehicleDetail(String locationId);
}