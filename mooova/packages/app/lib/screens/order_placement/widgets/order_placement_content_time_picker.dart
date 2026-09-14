import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../core/hooks/flutter_hooks.dart';

class OrderPlacementContentTimePicker extends HookWidget {
  final ValueSetter<List<DateTime>> onSelectedTimesChanged;
  final VoidCallback onSelectedTimesLimitClicked;

  const OrderPlacementContentTimePicker({
    super.key,
    required this.onSelectedTimesChanged,
    required this.onSelectedTimesLimitClicked,
  });

  @override
  Widget build(BuildContext context) {
    final selected = useState(<DateTime>[]);
    final now = DateTime.now().add(const Duration(minutes: 30));
    final today = DateTime(now.year, now.month, now.day, now.hour);
    final tomorrow = today.add(const Duration(days: 1));
    final timeMap = useMemoized(() {
      final todayList = <DateTime>[];
      final tomorrowList = <DateTime>[];

      DateTime next = today;
      while (today.day == next.day) {
        todayList.add(next);
        next = next.add(const Duration(hours: 1));
      }

      while (tomorrow.day == next.day) {
        tomorrowList.add(next);
        next = next.add(const Duration(hours: 1));
      }

      return [
        MapEntry(LocaleKeys.Today.tr(), todayList),
        MapEntry(LocaleKeys.Tomorrow.tr(), tomorrowList),
      ];
    }, [today, tomorrow, context.locale]);

    usePostFrameEffect(() {
      onSelectedTimesChanged(selected.value);
      return null;
    }, [selected.value]);

    return SectionedTimePicker(
      times: timeMap,
      selected: selected.value,
      onTimeClicked: (value) {
        if (selected.value.contains(value)) {
          final next = selected.value.where((e) => e != value).toList();
          selected.value = next;
        } else if (selected.value.length < 5) {
          final next = selected.value.toList().also((it) => it.add(value));
          selected.value = next;
        } else {
          onSelectedTimesLimitClicked();
        }
      },
    );
  }
}
