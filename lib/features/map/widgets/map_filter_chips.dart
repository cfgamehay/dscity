import 'package:flutter/material.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/MapFilterType.dart';

class MapFilterChips extends StatelessWidget {
  final MapFilterType selectedFilter;
  final ValueChanged<MapFilterType> onChanged;

  const MapFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: MapFilterType.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = MapFilterType.values[index];
          final selected = item == selectedFilter;

          return ChoiceChip(
            label: Text(item.label),
            selected: selected,
            onSelected: (_) => onChanged(item),
            backgroundColor: color.surface,
            selectedColor: color.surface,
            side: BorderSide(
              color: selected ? color.primary : color.outline.withValues(alpha: 0.4),
            ),
            labelStyle: TextStyle(
              color: color.primary,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          );
        },
      ),
    );
  }
}