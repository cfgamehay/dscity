import 'package:dscity_mobile_app/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class MapSearchBar extends StatefulWidget {
  final ValueChanged<String> searchInputChange;
  final VoidCallback showBottomModal;
  final VoidCallback onOpenFilter;
  final bool isFilterActive;

  const MapSearchBar({
    super.key,
    required this.searchInputChange,
    required this.showBottomModal,
    required this.onOpenFilter,
    this.isFilterActive = false,
  });

  @override
  State<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.outline.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    hintText: 'Tìm địa điểm, bãi đỗ xe...',
                    contentPadding: EdgeInsets.zero,
                    focusedBorderColor: Colors.transparent,
                    enabledBorderColor: Colors.transparent,
                    onChanged: widget.searchInputChange,
                    onTap: widget.showBottomModal,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: widget.onOpenFilter,
          child: Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: widget.isFilterActive
                  ? AppColors.secondary.withValues(alpha: 0.12)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.isFilterActive
                    ? AppColors.secondary
                    : AppColors.outline.withValues(alpha: 0.35),
              ),
            ),
            child: Icon(
              Icons.tune,
              color: widget.isFilterActive
                  ? AppColors.secondary
                  : AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
