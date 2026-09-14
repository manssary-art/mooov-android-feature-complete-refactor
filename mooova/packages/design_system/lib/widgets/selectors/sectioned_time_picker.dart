import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../design_system.dart';

class SectionedTimePicker extends HookWidget {
  final List<MapEntry<String, List<DateTime>>> times;
  final List<DateTime>? selected;
  final ValueSetter<DateTime>? onTimeClicked;

  const SectionedTimePicker({
    super.key,
    required this.times,
    this.selected,
    this.onTimeClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final section in times) ...[
          if (section.value.isNotEmpty) ...[
            buildContent(
              context: context,
              title: section.key,
              times: section.value,
              selected: selected,
              onTimeClicked: onTimeClicked,
            ),
          ],
        ],
      ],
    );
  }

  Widget buildContent({
    required BuildContext context,
    required String title,
    required List<DateTime> times,
    required List<DateTime>? selected,
    required ValueSetter<DateTime>? onTimeClicked,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _SectionedTimePickerSection(
              times: times,
              selectedIndexes: selected?.map((e) => times.indexOf(e)).toList(),
              onTimeClicked: (index) => onTimeClicked?.call(times[index]),
            ),
          ],
        ),
      );
}

class _SectionedTimePickerSection extends HookWidget {
  final List<DateTime> times;
  final List<int>? selectedIndexes;
  final ValueSetter<int>? onTimeClicked;

  const _SectionedTimePickerSection({
    super.key,
    required this.times,
    this.selectedIndexes,
    this.onTimeClicked,
  });

  @override
  Widget build(BuildContext context) {
    final items = useMemoized(
      () => times.map((e) => '${e.hour}-${e.add(const Duration(hours: 1)).hour}').toList(),
      [times],
    );

    return TagTextPicker(
      items: items,
      selectedIndexes: selectedIndexes,
      onItemClicked: onTimeClicked,
    );
  }
}
