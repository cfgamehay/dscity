import '../constants/enum.dart';

extension MapFilterTypeX on MapFilterType {
  String get label {
    switch (this) {
      case MapFilterType.parking:
        return 'Bãi đậu xe';
      case MapFilterType.car:
        return 'Ô tô';
      case MapFilterType.motorbike:
        return 'Xe máy';
      case MapFilterType.sharing:
        return 'Chia sẻ';
    }
  }
}