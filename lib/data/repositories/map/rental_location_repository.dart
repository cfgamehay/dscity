import '../../models/map/rental_location.dart';

abstract class RentalLocationRepository {
  Future<List<RentalLocation>> getLocations();
}