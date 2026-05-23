import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../data/models/sharing/place_suggestion.dart';
import '../provider/sharing_search_provider.dart';
import '../provider/sharing_search_state.dart';
import '../widgets/sharing_tab_switch.dart';
import '../widgets/sharing_trip_card.dart';
import 'share_detail_page.dart';

enum _PlaceTarget {
  tripPickup,
  tripDropoff,
}

enum _PlacePickerMode {
  suggestion,
  manual,
}

class SharingPage extends ConsumerStatefulWidget {
  const SharingPage({super.key});

  @override
  ConsumerState<SharingPage> createState() => _SharingPageState();
}

class _SharingPageState extends ConsumerState<SharingPage> {
  final _sharePickupController = TextEditingController();
  final _shareDropoffController = TextEditingController();
  final _sharePriceController = TextEditingController();
  final _shareNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _sharePickupController.addListener(() {
      ref
          .read(sharingSearchProvider.notifier)
          .updateSharePickupText(_sharePickupController.text);
    });
    _shareDropoffController.addListener(() {
      ref
          .read(sharingSearchProvider.notifier)
          .updateShareDropoffText(_shareDropoffController.text);
    });
    _sharePriceController.addListener(() {
      ref
          .read(sharingSearchProvider.notifier)
          .updateSharePriceText(_sharePriceController.text);
    });
    _shareNoteController.addListener(() {
      ref
          .read(sharingSearchProvider.notifier)
          .updateShareNote(_shareNoteController.text);
    });

    Future.microtask(() async {
      await ref.read(sharingSearchProvider.notifier).firstLoad();
    });
  }

  @override
  void dispose() {
    _sharePickupController.dispose();
    _shareDropoffController.dispose();
    _sharePriceController.dispose();
    _shareNoteController.dispose();
    super.dispose();
  }

  Future<void> _pickPlace(_PlaceTarget target) async {
    final notifier = ref.read(sharingSearchProvider.notifier);
    final item = await showModalBottomSheet<PlaceSuggestion>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PlacePickerSheet(
        title: _titleForTarget(target),
        defaultSuggestionsBuilder: (state) =>
            _buildDefaultSuggestions(state, target),
      ),
    );

    notifier.clearPlaceSearch();
    if (item != null) {
      _applyPickedPlace(target, item);
    }
  }

  List<PlaceSuggestion> _buildDefaultSuggestions(
    SharingSearchState state,
    _PlaceTarget target,
  ) {
    final suggestions = <PlaceSuggestion>[
      ...state.recentPlaces,
      ...(target == _PlaceTarget.tripPickup
          ? state.popularPlaces
          : state.suggestedDestinations.isNotEmpty
              ? state.suggestedDestinations
              : state.popularPlaces),
    ];

    final seen = <String>{};
    return suggestions.where((item) => seen.add(item.id)).toList();
  }

  String _titleForTarget(_PlaceTarget target) {
    switch (target) {
      case _PlaceTarget.tripPickup:
        return 'Chọn điểm đi';
      case _PlaceTarget.tripDropoff:
        return 'Chọn điểm đến';
    }
  }

  void _applyPickedPlace(_PlaceTarget target, PlaceSuggestion item) {
    final notifier = ref.read(sharingSearchProvider.notifier);

    switch (target) {
      case _PlaceTarget.tripPickup:
        notifier.updatePickupPlace(item);
        break;
      case _PlaceTarget.tripDropoff:
        notifier.updateDropoffPlace(item);
        break;
    }
  }

  Future<void> _pickTime({required bool isShareRide}) async {
    final state = ref.read(sharingSearchProvider);
    final initialDateTime = isShareRide ? state.shareTime : state.selectedTime;

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDateTime),
    );

    if (picked == null) return;

    final nextTime = initialDateTime.copyWith(
      hour: picked.hour,
      minute: picked.minute,
    );

    if (isShareRide) {
      ref.read(sharingSearchProvider.notifier).updateShareTime(nextTime);
    } else {
      ref.read(sharingSearchProvider.notifier).updateSelectedTime(nextTime);
    }
  }

  Future<void> _submitShareRide() async {
    final success =
        await ref.read(sharingSearchProvider.notifier).submitShareRide();
    if (!mounted) return;

    if (success) {
      _sharePickupController.clear();
      _shareDropoffController.clear();
      _sharePriceController.clear();
      _shareNoteController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã đăng chuyến chia sẻ xe.')),
      );
    } else {
      final state = ref.read(sharingSearchProvider);
      if (state.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sharingSearchProvider);
    final notifier = ref.read(sharingSearchProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Chia sẻ phương tiện'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SharingTabSwitch(
              activeTab: state.activeTab,
              onChanged: notifier.changeTab,
            ),
            const SizedBox(height: 16),
            if (state.activeTab == SharingTab.findTrip) ...[
              _PlaceField(
                icon: Icons.location_on_outlined,
                label: 'Điểm đi',
                value: state.pickupPlace?.title ?? '',
                placeholder: 'Nhập điểm đi',
                onTap: () => _pickPlace(_PlaceTarget.tripPickup),
              ),
              const SizedBox(height: 12),
              _PlaceField(
                icon: Icons.location_on_outlined,
                label: 'Điểm đến',
                value: state.dropoffPlace?.title ?? '',
                placeholder: 'Nhập điểm đến',
                onTap: () => _pickPlace(_PlaceTarget.tripDropoff),
              ),
              const SizedBox(height: 12),
              _PlaceField(
                icon: Icons.access_time_outlined,
                label: 'Thời gian',
                value:
                    'Hôm nay, ${state.selectedTime.hour.toString().padLeft(2, '0')}:${state.selectedTime.minute.toString().padLeft(2, '0')}',
                placeholder: 'Chọn giờ',
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _pickTime(isShareRide: false),
              ),
              const SizedBox(height: 16),
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
                  onPressed: notifier.searchTrips,
                  child: const Text(
                    'Tìm chuyến',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _TripFilterRow(
                currentFilter: state.tripFilter,
                onChanged: notifier.changeTripFilter,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Gợi ý chuyến đi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  if (state.isLoading)
                    const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: state.trips.isEmpty
                    ? const Center(
                        child: Text(
                          'Chưa có chuyến phù hợp',
                          style: TextStyle(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: state.trips.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final trip = state.trips[index];
                          return SharingTripCard(
                            trip: trip,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ShareDetailPage(locationId: trip.id),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ] else ...[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _InputCard(
                        label: 'Điểm đón',
                        child: CustomTextField(
                          controller: _sharePickupController,
                          hintText: 'Nhập điểm đón',
                          contentPadding: EdgeInsets.zero,
                          focusedBorderColor: Colors.transparent,
                          enabledBorderColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _InputCard(
                        label: 'Điểm trả',
                        child: CustomTextField(
                          controller: _shareDropoffController,
                          hintText: 'Nhập điểm trả',
                          contentPadding: EdgeInsets.zero,
                          focusedBorderColor: Colors.transparent,
                          enabledBorderColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _PlaceField(
                        icon: Icons.access_time_outlined,
                        label: 'Giờ xuất phát',
                        value:
                            'Hôm nay, ${state.shareTime.hour.toString().padLeft(2, '0')}:${state.shareTime.minute.toString().padLeft(2, '0')}',
                        placeholder: 'Chọn giờ',
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _pickTime(isShareRide: true),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _InputCard(
                              label: 'Số ghế',
                              child: Row(
                                children: [
                                  _SeatButton(
                                    icon: Icons.remove,
                                    onTap: ref
                                        .read(sharingSearchProvider.notifier)
                                        .decreaseShareSeats,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${state.shareSeats}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  _SeatButton(
                                    icon: Icons.add,
                                    onTap: ref
                                        .read(sharingSearchProvider.notifier)
                                        .increaseShareSeats,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _InputCard(
                              label: 'Giá / chỗ',
                              child: CustomTextField(
                                controller: _sharePriceController,
                                keyboardType: TextInputType.number,
                                hintText: '40000',
                                contentPadding: EdgeInsets.zero,
                                focusedBorderColor: Colors.transparent,
                                enabledBorderColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _InputCard(
                        label: 'Ghi chú',
                        child: CustomTextField(
                          controller: _shareNoteController,
                          maxLines: 4,
                          minLines: 4,
                          hintText: 'Thêm ghi chú cho hành khách...',
                          contentPadding: EdgeInsets.zero,
                          focusedBorderColor: Colors.transparent,
                          enabledBorderColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(height: 16),
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
                          onPressed: state.isSubmittingShareRide
                              ? null
                              : _submitShareRide,
                          child: state.isSubmittingShareRide
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Đăng chuyến',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TripFilterRow extends StatelessWidget {
  final TripResultFilter currentFilter;
  final ValueChanged<TripResultFilter> onChanged;

  const _TripFilterRow({
    required this.currentFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'Tất cả',
            selected: currentFilter == TripResultFilter.all,
            onTap: () => onChanged(TripResultFilter.all),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Rẻ nhất',
            selected: currentFilter == TripResultFilter.cheapest,
            onTap: () => onChanged(TripResultFilter.cheapest),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Nhiều chỗ',
            selected: currentFilter == TripResultFilter.available,
            onTap: () => onChanged(TripResultFilter.available),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Khởi hành sớm',
            selected: currentFilter == TripResultFilter.earliest,
            onTap: () => onChanged(TripResultFilter.earliest),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.secondary.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? AppColors.secondary : AppColors.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.secondary : AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _PlaceField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String placeholder;
  final Widget? trailing;
  final VoidCallback onTap;

  const _PlaceField({
    required this.icon,
    required this.label,
    required this.value,
    required this.placeholder,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value.trim().isNotEmpty;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasValue ? value : placeholder,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: hasValue ? FontWeight.w700 : FontWeight.w500,
                      color: hasValue
                          ? AppColors.primary
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  final String label;
  final Widget child;

  const _InputCard({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _SeatButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SeatButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  final PlaceSuggestion item;
  final VoidCallback onTap;

  const _SuggestionTile({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: item.isCurrentLocation
                  ? AppColors.secondary.withValues(alpha: 0.12)
                  : AppColors.surfaceVariant,
              child: Icon(
                item.isCurrentLocation
                    ? Icons.my_location
                    : Icons.location_on_outlined,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlacePickerSheet extends ConsumerStatefulWidget {
  final String title;
  final List<PlaceSuggestion> Function(SharingSearchState state)
      defaultSuggestionsBuilder;

  const _PlacePickerSheet({
    required this.title,
    required this.defaultSuggestionsBuilder,
  });

  @override
  ConsumerState<_PlacePickerSheet> createState() => _PlacePickerSheetState();
}

class _PlacePickerSheetState extends ConsumerState<_PlacePickerSheet> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  _PlacePickerMode _mode = _PlacePickerMode.suggestion;
  String _query = '';

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(sharingSearchProvider.notifier);
    final state = ref.watch(sharingSearchProvider);
    final suggestions = _mode == _PlacePickerMode.suggestion
        ? widget.defaultSuggestionsBuilder(state)
        : (_query.trim().isEmpty ? const <PlaceSuggestion>[] : state.placeResults);

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.78,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _ModeChip(
                    label: 'Gợi ý nhanh',
                    selected: _mode == _PlacePickerMode.suggestion,
                    onTap: () {
                      setState(() {
                        _mode = _PlacePickerMode.suggestion;
                        _query = '';
                        _controller.clear();
                      });
                      notifier.clearPlaceSearch();
                      _focusNode.unfocus();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ModeChip(
                    label: 'Tự tìm',
                    selected: _mode == _PlacePickerMode.manual,
                    onTap: () {
                      setState(() {
                        _mode = _PlacePickerMode.manual;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_mode == _PlacePickerMode.manual) ...[
              CustomTextField(
                controller: _controller,
                focusNode: _focusNode,
                hintText: 'Nhập địa điểm để tìm nhanh...',
                icon: const Icon(Icons.search, color: AppColors.primary),
                iconIncludeVerticalLine: false,
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                  notifier.searchPlaces(value);
                },
              ),
              const SizedBox(height: 16),
            ] else
              const SizedBox(height: 4),
            if (_mode == _PlacePickerMode.manual && state.isSearchingPlaces)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              Expanded(
                child: suggestions.isEmpty
                    ? const Center(
                        child: Text(
                          'Chưa có gợi ý phù hợp',
                          style: TextStyle(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: suggestions.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = suggestions[index];
                          return _SuggestionTile(
                            item: item,
                            onTap: () => Navigator.pop(context, item),
                          );
                        },
                      ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.secondary.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? AppColors.secondary : AppColors.outlineVariant,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.secondary : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
