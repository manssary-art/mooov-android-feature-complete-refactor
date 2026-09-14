import 'dart:math';

extension DateTimeExt on DateTime {
  DateTime subtractExact({
    int years = 0,
    int months = 0,
    int weeks = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) {
    DateTime _dateTime = subtract(
      Duration(
        days: days + weeks * 7,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
        microseconds: microseconds,
      ),
    );
    _dateTime = _addMonths(_dateTime, -months);
    _dateTime = _addMonths(_dateTime, -years * 12);
    return _dateTime;
  }

  DateTime _addMonths(DateTime from, int months) {
    final r = months % 12;
    final q = (months - r) ~/ 12;
    var newYear = from.year + q;
    var newMonth = from.month + r;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    final newDay = min(from.day, _daysInMonth(newYear, newMonth));
    if (from.isUtc) {
      return DateTime.utc(
        newYear,
        newMonth,
        newDay,
        from.hour,
        from.minute,
        from.second,
        from.millisecond,
        from.microsecond,
      );
    } else {
      return DateTime(
        newYear,
        newMonth,
        newDay,
        from.hour,
        from.minute,
        from.second,
        from.millisecond,
        from.microsecond,
      );
    }
  }

  int _daysInMonth(int year, int month) {
    var result = _daysInMonthArray[month];
    if (month == 2 && _isLeapYear(year)) result++;
    return result;
  }

  bool _isLeapYear(int year) => (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  static const _daysInMonthArray = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
}
