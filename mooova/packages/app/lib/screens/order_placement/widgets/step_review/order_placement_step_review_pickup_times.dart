part of 'order_placement_step_review.dart';

class _OrderPlacementStepReviewContentPickUpTimes extends HookWidget {
  final List<DateTime> times;

  const _OrderPlacementStepReviewContentPickUpTimes({
    super.key,
    required this.times,
  });

  static final _formatter = DateFormat().add_MEd();

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

    return Column(
      children: [
        SimpleAssetImageTextTile(
          image: Assets.images.iconCalendarGreen,
          text: LocaleKeys.PickupDate.tr(),
        ),
        const SizedBox(height: 8),
        SectionedTimePicker(times: timeEntries)
      ],
    );
  }
}