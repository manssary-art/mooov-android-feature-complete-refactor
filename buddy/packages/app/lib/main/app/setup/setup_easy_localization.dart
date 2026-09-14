import 'dart:convert';

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';



class SetupEasyLocalization extends HookWidget {
  final WidgetBuilder builder;

  const SetupEasyLocalization({
    super.key,
    required this.builder,
  });

  static const _intlPath = 'assets/intl';

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() => _supportedLocalesFuture());
    return FutureBuilder<List<Locale>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        return EasyLocalization(
          supportedLocales: snapshot.data ??
              const [
                Locale('en'),
              ],
          fallbackLocale: const Locale('en'),
          useOnlyLangCode: true,
          path: _intlPath,
          child: Builder(builder: builder),
        );
      },
    );
  }

  static List<Locale>? _supportedLocales;

  Future<List<Locale>> _supportedLocalesFuture() async {
    while (_supportedLocales == null) {
      try {
        final content = await rootBundle.loadString('$_intlPath/_meta.json');
        final map = json.decode(content) as Map<String, dynamic>;
        final locales = (map['locales'] as List?)?.mapNotNull((e) => e as String).toList();
        _supportedLocales = locales?.mapNotNull((e) => Locale(e));
      } catch (e) {
        await Future.delayed(const Duration(seconds: 5));
      }
    }
    return _supportedLocales!;
  }
}
