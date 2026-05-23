import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../provider/parking_detail_provider.dart';
import '../provider/parking_detail_state.dart';
import '../widgets/parking_detail_content.dart';

class ParkingDetailPage extends ConsumerStatefulWidget {
  final String locationId;

  const ParkingDetailPage({
    super.key,
    required this.locationId,
  });

  @override
  ConsumerState<ParkingDetailPage> createState() => _ParkingDetailPageState();
}

class _ParkingDetailPageState extends ConsumerState<ParkingDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref
          .read(parkingDetailProvider.notifier)
          .loadDetail(widget.locationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(parkingDetailProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildBody(state),
    );
  }

  Widget _buildBody(ParkingDetailState state) {
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
        child: Text('Không có dữ liệu chi tiết bãi đậu'),
      );
    }

    return ParkingDetailContent(
      detail: state.detail!,
      onBack: () => Navigator.pop(context),
      onFavorite: () {},
      onBooking: () {},
    );
  }
}