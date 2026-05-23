import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../provider/vehicle_detail_provider.dart';
import '../provider/vehicle_detail_state.dart';
import '../widgets/vehicle_detail_content.dart';

class VehicleDetailPage extends ConsumerStatefulWidget {
  final String locationId;

  const VehicleDetailPage({
    super.key,
    required this.locationId,
  });

  @override
  ConsumerState<VehicleDetailPage> createState() => _VehicleDetailPageState();
}

class _VehicleDetailPageState extends ConsumerState<VehicleDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref
          .read(vehicleDetailProvider.notifier)
          .loadDetail(widget.locationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehicleDetailProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildBody(state),
    );
  }

  Widget _buildBody(VehicleDetailState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.error != null) {
      return Center(
        child: Text(state.error!),
      );
    }

    if (state.detail == null) {
      return const Center(
        child: Text('Không có dữ liệu chi tiết'),
      );
    }

    return VehicleDetailContent(
      detail: state.detail!,
      selectedPriceOption: state.selectedPriceOption,
      onBack: () => Navigator.pop(context),
      onAction: () {},
      onPrimaryAction: () {},
      onSelectPriceOption: ref.read(vehicleDetailProvider.notifier).selectPriceOption,
    );
  }
}