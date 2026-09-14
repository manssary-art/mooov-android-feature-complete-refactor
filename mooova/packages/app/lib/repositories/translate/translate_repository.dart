import 'package:async/async.dart';

abstract interface class TranslateRepository {
  Future<Result<String>> translate({
    required String value,
    required String targetLocale,
  });
}
