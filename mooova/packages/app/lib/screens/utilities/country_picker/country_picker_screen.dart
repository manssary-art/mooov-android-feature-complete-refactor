import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

class CountryPickerScreen extends StatelessWidget {
  final Country? initial;
  final ValueSetter<Country> onValuePicked;

  const CountryPickerScreen({
    super.key,
    required this.onValuePicked,
    this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return _CountryPickerScreenContent(
      onValuePicked: onValuePicked,
      initial: initial,
    );
  }
}

class _CountryPickerScreenContent extends HookWidget {
  final Country? initial;
  final ValueSetter<Country> onValuePicked;

  const _CountryPickerScreenContent({
    super.key,
    required this.onValuePicked,
    this.initial,
  });

  @override
  Widget build(BuildContext context) {
    const itemHeight = 80.0;
    final initialIndex = initial?.let((it) => _codeWithIndex[it.code]) ?? 0;
    final initialOffset = initialIndex * itemHeight;
    final scrollableController = useScrollController(initialScrollOffset: initialOffset);
    final controller = useTextEditingController();
    final search = useValueListenable(controller).text;
    final items = useValueChanged<String, List<Country>>(search, (oldValue, oldResult) {
          if (search.isEmpty) return _alphabetical;
          return _alphabetical
              .where(
                (e) =>
                    e.dialCode.containsOther(search, ignoreCase: true) ||
                    search.containsOther(e.dialCode, ignoreCase: true) ||
                    e.name.containsOther(search, ignoreCase: true) ||
                    search.containsOther(e.name, ignoreCase: true) ||
                    e.code.containsOther(search, ignoreCase: true) ||
                    search.containsOther(e.code, ignoreCase: true),
              )
              .toList();
        }) ??
        _alphabetical;

    return SafeArea(
      child: Column(
        children: [
          SearchBar(
            controller: controller,
            hintText: LocaleKeys.Country.tr(),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    controller: scrollableController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final country = items[index];
                      return Clickable(
                        indicator: ClickableIndicator.nothing,
                        onTap: () => onValuePicked(country),
                        child: SizedBox(
                          height: itemHeight,
                          child: Column(
                            children: [
                              ListTile(
                                leading: country.asset.image(width: 40, height: 40),
                                title: Text(country.name),
                                trailing: Text(country.dialCode),
                              ),
                              const Divider()
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final entry in _firstLetterWithIndex.entries) ...[
                        Clickable(
                          onTap: () => scrollableController.animateTo(
                            entry.value * itemHeight,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                            child: Text(
                              entry.key,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final _firstLetterWithIndex = <String, int>{};
final _codeWithIndex = <String, int>{};
final _alphabetical = Country.values.toList().sorted((a, b) => a.name.compareTo(b.name)).also((countries) {
  countries.asMap().forEach((index, value) {
    _firstLetterWithIndex.putIfAbsent(value.name[0], () => index);
    _codeWithIndex.putIfAbsent(value.code, () => index);
  });
});
