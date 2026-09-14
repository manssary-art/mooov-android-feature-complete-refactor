import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resultOf', () {
    test('should return ValueResult', () async {
      final result = await resultOf(() async {
        return Result.value('value');
      });

      expect(result, isA<ValueResult<String>>());
      // expect(result.asValueOrThrow, equals('value'));
    });

    test('should return ErrorResult', () async {
      final result = await resultOf(() async {
        return Result.error(AssertionError());
      });

      expect(result, isA<ErrorResult>());
      // expect(result.asErrorValueOrThrow.$1, isA<AssertionError>());
    });

    test('should return ErrorResult when throws', () async {
      final result = await resultOf(() async {
        throw AssertionError();
      });

      expect(result, isA<ErrorResult>());
      // expect(result.asErrorValueOrThrow.$1, isA<AssertionError>());
    });

    test('should return ErrorResult when throws in a async map', () async {
      final result = await resultOf(() async {
        return Future.value('').asValueResult().mapValue((e) => throw AssertionError());
      });

      expect(result, isA<ErrorResult>());
      // expect(result.asErrorValueOrThrow.$1, isA<AssertionError>());
    });
  });
}
