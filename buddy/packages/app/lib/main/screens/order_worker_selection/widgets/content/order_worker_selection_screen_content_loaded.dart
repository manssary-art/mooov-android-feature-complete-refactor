part of 'order_worker_selection_screen_content.dart';

class OrderWorkerSelectionScreenContentLoaded extends HookWidget {
  final List<(UserModel, List<DateTime>)> candidates;
  final (String userId, DateTime time)? selected;
  final VoidCallback onNavBackClicked;
  final void Function(String userId) onUserProfileImageClicked;
  final void Function(String userId) onUserVehicleImageClicked;
  final void Function(String userId, DateTime time) onTimeClicked;
  final void Function() onSubmitClicked;

  const OrderWorkerSelectionScreenContentLoaded({
    super.key,
    required this.candidates,
    required this.selected,
    required this.onNavBackClicked,
    required this.onUserProfileImageClicked,
    required this.onUserVehicleImageClicked,
    required this.onTimeClicked,
    required this.onSubmitClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _OrderWorkerSelectionScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final candidate in candidates) ...[
                        buildListItem(candidate),
                        const Divider(height: 80),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: FilledButton(
                onPressed: onSubmitClicked.takeIf((it) => selected != null),
                child: Text(LocaleKeys.Confirm.tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(
    (UserModel, List<DateTime>) candidate,
  ) =>
      HookBuilder(
        builder: (context) {
          final formatter = useMemoized(() => DateFormat().add_MEd());
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final tomorrow = today.add(const Duration(days: 1));
          final timeEntries = useMemoized(() {
            final timeMap = candidate.$2.fold<Map<String, List<DateTime>>>({}, (map, time) {
              final date = DateTime(time.year, time.month, time.day);
              String key;
              if (date.compareTo(today) == 0) {
                key = LocaleKeys.Today.tr();
              } else if (date.compareTo(tomorrow) == 0) {
                key = LocaleKeys.Tomorrow.tr();
              } else {
                key = formatter.format(date);
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
          }, [candidate.$2, today, tomorrow]);

          final selectedTimes = useMemoized<List<DateTime>>(() {
            if (selected == null) return [];
            if (candidate.$1.userId != selected!.$1) return [];
            return [selected!.$2];
          }, [selected, candidate]);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderWorkerSelectionCandidateHeaderListItem(
                user: candidate.$1,
                onUserProfileImageClicked: () => onUserProfileImageClicked(candidate.$1.userId),
                onUserVehicleImageClicked: () => onUserVehicleImageClicked(candidate.$1.userId),
              ),
              const SizedBox(height: 16),
              SectionedTimePicker(
                times: timeEntries,
                selected: selectedTimes,
                onTimeClicked: (value) => onTimeClicked(candidate.$1.userId, value),
              )
            ],
          );
        },
      );
}
