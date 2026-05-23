import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../provider/booking_provider.dart';
import '../provider/booking_state.dart';
import '../widgets/booking_history_card.dart';
import '../widgets/booking_tab_switch.dart';
import 'booking_detail_page.dart';

class BookingPage extends ConsumerStatefulWidget {
  final bool showAppBar;

  const BookingPage({
    super.key,
    this.showAppBar = false,
  });

  @override
  ConsumerState<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(bookingProvider.notifier).firstLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingProvider);
    final notifier = ref.read(bookingProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: widget.showAppBar
          ? AppBar(
              title: const Text('Đặt chỗ của tôi'),
            )
          : null,
      body: SafeArea(
        top: !widget.showAppBar,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              if (!widget.showAppBar) ...[
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Đặt chỗ của tôi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              BookingTabSwitch(
                activeTab: state.activeTab,
                onChanged: notifier.changeTab,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    _headlineForTab(state.activeTab),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  if (state.isLoading)
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: state.error != null
                    ? Center(child: Text(state.error!))
                    : state.visibleItems.isEmpty
                        ? Center(
                            child: Text(
                              _emptyTextForTab(state.activeTab),
                              style: const TextStyle(
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: state.visibleItems.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = state.visibleItems[index];
                              return BookingHistoryCard(
                                item: item,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          BookingDetailPage(item: item),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _headlineForTab(BookingTab tab) {
    switch (tab) {
      case BookingTab.active:
        return 'Các đơn đang diễn ra';
      case BookingTab.history:
        return 'Lịch sử đặt chỗ';
      case BookingTab.saved:
        return 'Các mục đã lưu';
    }
  }

  String _emptyTextForTab(BookingTab tab) {
    switch (tab) {
      case BookingTab.active:
        return 'Bạn chưa có đơn đặt nào đang diễn ra';
      case BookingTab.history:
        return 'Chưa có lịch sử đặt chỗ';
      case BookingTab.saved:
        return 'Bạn chưa lưu mục nào';
    }
  }
}
