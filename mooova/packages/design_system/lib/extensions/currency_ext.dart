import 'package:core/core.dart';
import 'package:intl/intl.dart';

extension CurrencyExt on Currency {
  static final _cache = <Currency, NumberFormat>{};

  String format(Money value) {
    return _formatter.format(value);
  }

  String symbol() {
    return _formatter.currencySymbol;
  }

  NumberFormat get _formatter => _cache.putIfAbsent(this, () {
        String? locale;
        if (this == Currency.SEK) {
          locale = 'sv_se';
        }

        return NumberFormat.simpleCurrency(
          locale: locale,
          name: code,
          decimalDigits: 0,
        );
      });
}
