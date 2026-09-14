part of 'constants.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
  ),
);

final _loggerSimple = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
  ),
);

extension LoggerExt on Logger {
  Logger get simple => _loggerSimple;
}
