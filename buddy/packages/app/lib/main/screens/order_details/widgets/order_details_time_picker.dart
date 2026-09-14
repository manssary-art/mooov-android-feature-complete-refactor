import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/types/order_state_type.dart';
import '../models/order_details_display_mode.dart';

final _formatter = DateFormat().add_MEd();

class OrderDetailsTimePicker extends HookWidget {
  final List<DateTime> times;
  final OrderState orderState;
  final OrderDetailsDisplayMode displayMode;
  final VoidCallback onDeleteOrderClicked;
  final ValueSetter<List<DateTime>> onApplyToOrderClicked;
  final VoidCallback onWithdrawApplyToOrderClicked;

  const OrderDetailsTimePicker({
    super.key,
    required this.times,
    required this.orderState,
    required this.displayMode,
    required this.onDeleteOrderClicked,
    required this.onApplyToOrderClicked,
    required this.onWithdrawApplyToOrderClicked,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final timeEntries = useMemoized(() {
      final timeMap = times.fold<Map<String, List<DateTime>>>({}, (map, time) {
        final date = DateTime(time.year, time.month, time.day);
        String key;
        if (date.compareTo(today) == 0) {
          key = LocaleKeys.Today.tr();
        } else if (date.compareTo(tomorrow) == 0) {
          key = LocaleKeys.Tomorrow.tr();
        } else {
          key = _formatter.format(date);
        }

        final list = map[key] ?? <DateTime>[];
        list.add(time);
        map[key] = list;
        return map;
      });

      return <MapEntry<String, List<DateTime>>>[
        LocaleKeys.Today.tr().let((it) => MapEntry(it, timeMap.remove(it) ?? [])),
        LocaleKeys.Tomorrow.tr().let((it) => MapEntry(it, timeMap.remove(it) ?? [])),
        ...timeMap.entries.toList()
      ];
    }, [times, today, tomorrow]);

    final selectedIndexes = useState<Set<DateTime>>({});
    final displayMode = this.displayMode;
    final isNew = orderState == OrderState.created;

    if (displayMode is OrderDetailsDisplayMode$Owner) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleAssetImageTextTile(
            image: Assets.images.iconCalendarGreen,
            text: LocaleKeys.PickupDate.tr(),
          ),
          const SizedBox(height: 8),
          SectionedTimePicker(
            times: timeEntries,
          ),
          if (isNew) ...[
            const SizedBox(height: 24),
            FilledButton(
              onPressed: onDeleteOrderClicked,
              child: Text(LocaleKeys.DeleteOrder.tr()),
            ),
          ],
        ],
      );
    }

    if (isNew && displayMode is OrderDetailsDisplayMode$WorkerApplied) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleAssetImageTextTile(
            image: Assets.images.iconCalendarGreen,
            text: LocaleKeys.PickupDate.tr(),
          ),
          const SizedBox(height: 8),
          SectionedTimePicker(
            times: timeEntries,
            selected: displayMode.appliedPickupTimes,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: onWithdrawApplyToOrderClicked,
            child: Text(LocaleKeys.WithdrawApply.tr()),
          ),
        ],
      );
    }

    if (displayMode is OrderDetailsDisplayMode$WorkerAssigned) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleAssetImageTextTile(
            image: Assets.images.iconCalendarGreen,
            text: LocaleKeys.PickupDate.tr(),
          ),
          const SizedBox(height: 8),
          SectionedTimePicker(
            times: timeEntries,
            selected: [displayMode.finalPickupTime],
          ),
        ],
      );
    }

    if (isNew && displayMode is OrderDetailsDisplayMode$Visitor) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleAssetImageTextTile(
            image: Assets.images.iconCalendarGreen,
            text: LocaleKeys.PickUpTimeDes.tr(),
          ),
          const SizedBox(height: 8),
          SectionedTimePicker(
            times: timeEntries,
            selected: selectedIndexes.value.toList(),
            onTimeClicked: (index) {
              if (selectedIndexes.value.contains(index)) {
                final next = selectedIndexes.value.toSet().also((it) => it.remove(index));
                selectedIndexes.value = next;
              } else if (selectedIndexes.value.length < 4) {
                final next = selectedIndexes.value.toSet().also((it) => it.add(index));
                selectedIndexes.value = next;
              }
            },
          ),
          const SizedBox(height: 24),
          if (isNew) ...[
            FilledButton(
              onPressed:
                  selectedIndexes.value.isNotEmpty ? () => onApplyToOrderClicked(selectedIndexes.value.toList()) : null,
              child: Text(LocaleKeys.ApplyOrder.tr()),
            ),
          ],
        ],
      );
    }

    return Container();
  }
}
