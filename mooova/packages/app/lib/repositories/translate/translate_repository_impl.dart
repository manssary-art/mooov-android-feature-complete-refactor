import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:network_api/infr_network_api.dart';

import 'translate_repository.dart';

class TranslateRepositoryImpl implements TranslateRepository {
  final String googleCloudApiKey;
  final Dio dio;

  TranslateRepositoryImpl({
    required this.googleCloudApiKey,
    required this.dio,
  });

  static const url = 'https://translation.googleapis.com/language/translate/v2';
  static final inMemoryCache = <String, String>{};

  @override
  Future<Result<String>> translate({
    required String value,
    required String targetLocale,
  }) =>
      resultOf(() async {
        final cache = inMemoryCache['$targetLocale#$value'];
        if (cache != null) {
          return Result.value(cache);
        }

        final result = await dio.get<Map<String, dynamic>>(url, queryParameters: {
          'target': targetLocale,
          'key': googleCloudApiKey,
          'q': value,
          'format': 'text',
        });

        final data = result.data?['data'];
        final translations = data?['translations'] as List?;
        final translation = translations?.firstOrNull();
        final text = translation?['translatedText'];

        if (text != null) {
          inMemoryCache['$targetLocale#$value'] = text;
          return Result.value(text);
        } else {
          return Result.error(Exception('Unable to parse translation $result'));
        }
      });
}
