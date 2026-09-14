import 'package:core/core.dart';

extension DateTimeIntMapperExt on int {
  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true).toLocal();
  }
}

extension IntDateTimeMapperExt on DateTime {
  int toDtoTimeInt() {
    var utc = this;
    if (!isUtc) {
      utc = toUtc();
    }

    return utc.millisecondsSinceEpoch ~/ 1000;
  }
}

extension DateTimeListIntMapperExt on List<int> {
  List<DateTime> toDateTimes({bool sort = true}) {
    return map((e) => e.toDateTime()).toList().also((e) {
      if (sort) {
        e.sort((a, b) => a.millisecondsSinceEpoch - b.millisecondsSinceEpoch);
      }
    });
  }
}

extension IntListDateTimeMapperExt on List<DateTime> {
  List<int> toDtoTimeInts({bool sort = true}) {
    return map((e) => e.toDtoTimeInt()).toList().also((e) {
      if (sort) {
        e.sort((a, b) => a - b);
      }
    });
  }
}
