import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme.dart';
import '../provider/share_detail_provider.dart';
import '../provider/share_detail_state.dart';
import '../widgets/share_detail_content.dart';

class ShareDetailPage extends ConsumerStatefulWidget {
  final String locationId;

  const ShareDetailPage({
    super.key,
    required this.locationId,
  });

  @override
  ConsumerState<ShareDetailPage> createState() => _ShareDetailPageState();
}

class _ShareDetailPageState extends ConsumerState<ShareDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(shareDetailProvider.notifier).loadDetail(widget.locationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shareDetailProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildBody(state),
    );
  }

  Widget _buildBody(ShareDetailState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    if (state.detail == null) {
      return const Center(child: Text('Không có dữ liệu chuyến đi'));
    }

    return ShareDetailContent(
      detail: state.detail!,
      selectedSeats: state.selectedSeats,
      totalPrice: ref.read(shareDetailProvider.notifier).getTotalPrice(),
      onBack: () => Navigator.pop(context),
      onFavorite: () {},
      onJoin: () {},
      onChangeSeats: (value) {
        ref.read(shareDetailProvider.notifier).updateSelectedSeats(value);
      },
    );
  }
}
