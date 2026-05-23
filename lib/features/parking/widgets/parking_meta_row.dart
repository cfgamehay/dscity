import 'package:flutter/material.dart';

import 'parking_meta_chip.dart';

class ParkingMetaRow extends StatelessWidget {
  final String parkingTypeLabel;
  final String securityLabel;
  final String elevatorLabel;

  const ParkingMetaRow({
    super.key,
    required this.parkingTypeLabel,
    required this.securityLabel,
    required this.elevatorLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ParkingMetaChip(label: parkingTypeLabel)),
        const SizedBox(width: 8),
        Expanded(child: ParkingMetaChip(label: securityLabel)),
        const SizedBox(width: 8),
        Expanded(child: ParkingMetaChip(label: elevatorLabel)),
      ],
    );
  }
}