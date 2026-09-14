import 'package:core/core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'preview_config.dart';
import 'preview_mixin.dart';
import 'preview_storage.dart';

part 'preview_tools_options_section.dart';

part 'preview_tools_select_screen.dart';

part 'preview_tools_theme_section.dart';

class PreviewApp extends HookWidget {
  static Future<void> ensureInitialized() async {
    await PreviewStorage.ensureInitialized();
  }

  final List<PreviewMixin> screens;
  final List<Locale> availableLocales;
  final Widget Function(BuildContext, Widget, PreviewConfig) builder;

  const PreviewApp({
    required this.screens,
    required this.availableLocales,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return _PreviewApp(
      initialScreenKey: PreviewStorage.storage.getTyped<String?>(PreviewStorage.screenKey) ?? '',
      onScreenKeyChanged: (key) => PreviewStorage.storage.put(PreviewStorage.screenKey, key),
      availableLocales: availableLocales,
      screens: screens,
      builder: builder,
    );
  }
}

class _PreviewApp extends HookWidget {
  final String initialScreenKey;
  final List<Locale> availableLocales;
  final ValueSetter<String> onScreenKeyChanged;
  final List<_PreviewContainer> containers;
  final Widget Function(BuildContext, Widget, PreviewConfig) builder;

  _PreviewApp({
    required this.availableLocales,
    required this.initialScreenKey,
    required this.onScreenKeyChanged,
    required this.builder,
    required List<PreviewMixin> screens,
  }) : containers =
            screens.map((e) => _PreviewContainer(e)).toList().also((it) => it.sort((a, b) => a.name.compareTo(b.name)));

  @override
  Widget build(BuildContext context) {
    final containers = useState(this.containers);
    final initialIndex = containers.value.indexWhere((e) => e.name == initialScreenKey).let((it) => it == -1 ? 0 : it);
    final selectedIndex = useState(initialIndex);
    return Builder(
      builder: (context) => DevicePreview(
        availableLocales: availableLocales,
        tools: [
          _PreviewToolsSelectScreenSection(
            containers: containers,
            selectedIndex: selectedIndex,
            onSaveSelectedScreen: (index) => onScreenKeyChanged(containers.value[index].name),
          ),
          _PreviewToolsOptionsSection(
            containers: containers,
            selectedIndex: selectedIndex,
          ),
          const DeviceSection(),
          const SystemSection(),
          const AccessibilitySection(),
        ],
        enabled: true,
        builder: (context) {
          final child = Builder(
            builder: (context) {
              return DevicePreview.appBuilder(context, containers.value[selectedIndex.value].child);
            },
          );

          final config = PreviewConfig(
            locale: Locale(DevicePreview.locale(context)!.languageCode),
          );
          return builder(context, child, config);
        },
      ),
    );
  }
}

class _PreviewContainer {
  final String name;
  final Widget child;
  final ValueListenable<Map<String, PreviewOptionField>> fields;

  _PreviewContainer(
    PreviewMixin preview,
  )   : name = preview.name,
        child = preview,
        fields = preview.fields;
}
