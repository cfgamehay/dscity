import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/notification/app_notification.dart';
import '../provider/notification_provider.dart';
import '../provider/notification_state.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_tab_switch.dart';

class NotificationPage extends ConsumerStatefulWidget {
  final bool showAppBar;

  const NotificationPage({
    super.key,
    this.showAppBar = true,
  });

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(notificationProvider.notifier).firstLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: widget.showAppBar
          ? AppBar(
              title: const Text('Thông báo'),
              actions: [
                TextButton(
                  onPressed:
                      state.visibleItems.isEmpty ? null : notifier.markAllAsRead,
                  child: const Text('Đọc tất cả'),
                ),
              ],
            )
          : null,
      body: SafeArea(
        top: !widget.showAppBar,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              if (!widget.showAppBar) ...[
                Row(
                  children: [
                    const Text(
                      'Thông báo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: state.visibleItems.isEmpty
                          ? null
                          : notifier.markAllAsRead,
                      child: const Text('Đọc tất cả'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
              NotificationTabSwitch(
                activeTab: state.activeTab,
                onChanged: notifier.changeTab,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.error != null
                        ? Center(child: Text(state.error!))
                        : state.visibleItems.isEmpty
                            ? const Center(
                                child: Text(
                                  'Bạn chưa có thông báo phù hợp',
                                  style: TextStyle(
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
                                  return NotificationCard(
                                    item: item,
                                    onTap: () => _openNotification(item),
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

  Future<void> _openNotification(AppNotification item) async {
    ref.read(notificationProvider.notifier).markAsRead(item.id);

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.timeLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  item.message,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Đóng',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
