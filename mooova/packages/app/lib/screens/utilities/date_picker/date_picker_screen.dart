import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

class DatePickerScreen extends HookWidget {
  final DateTime? initial;
  final DateTime? min;
  final DateTime? max;
  final ValueSetter<DateTime?> onValuePicked;

  const DatePickerScreen({
    super.key,
    required this.onValuePicked,
    this.initial,
    this.min,
    this.max,
  });

  @override
  Widget build(BuildContext context) {
    final theme = useMemoized(() => MaterialBasedCupertinoThemeData(materialTheme: Theme.of(context)));
    final max = this.max ?? DateTime.now().subtractExact(years: 18);
    final min = this.min ?? DateTime.now().subtractExact(years: 100);
    final date = useRef(max);
    return Container(
      height: 320,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CupertinoApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Clickable(
                    onTap: () => onValuePicked(null),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Text(
                        LocaleKeys.Cancel.tr(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                  Clickable(
                    onTap: () => onValuePicked(date.value),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: Text(
                        LocaleKeys.OK.tr(),
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: Colors.blue,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: date.value,
                  minimumDate: min,
                  maximumDate: max,
                  showDayOfWeek: false,
                  mode: CupertinoDatePickerMode.date,
                  dateOrder: DatePickerDateOrder.ymd,
                  onDateTimeChanged: (DateTime value) {
                    date.value = value;
                  },
                ),
              ),
            ],
          )),
    );
  }
}
