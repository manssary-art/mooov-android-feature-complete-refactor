import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'preview_storage.dart';

mixin PreviewMixin on Widget {
  final _fields = _DebouncedValueNotifier<Map<String, PreviewOptionField>>({});

  ValueListenable<Map<String, PreviewOptionField>> get fields => _fields;

  String get name;

  bool usePreviewSwitch(String name, [bool? initial]) {
    final key = '${this.name}.usePreviewSwitch.$name';
    final initialValue = initial ?? PreviewStorage.storage.getTyped<bool?>(key) ?? false;
    return useValueListenable(
      _getField(
        key,
        _PreviewOptionField$Switch(
          initialValue,
          name: name,
          key: key,
        ),
      ),
    );
  }

  String usePreviewInput(String name, [String? initial]) {
    final key = '${this.name}.usePreviewInput.$name';
    final initialValue = initial ?? PreviewStorage.storage.getTyped<String?>(key) ?? '';
    return useValueListenable(
      _getField(
        key,
        _PreviewOptionField$Input(
          initialValue,
          name: name,
          key: key,
        ),
      ),
    );
  }

  num usePreviewInputNumeric(String name, [num? initial]) {
    final key = '${this.name}.usePreviewInputNumeric.$name';
    final initialValue = initial ?? PreviewStorage.storage.getTyped(key) ?? 0;
    return useValueListenable(
      _getField(
        key,
        _PreviewOptionField$Input(
          '$initialValue',
          name: name,
          key: key,
          formatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ),
    ).toDouble();
  }

  String usePreviewOptions(String name, List<String> options, [int? initial]) {
    final key = '${this.name}.usePreviewOptions.$name';
    final initialValue = initial ?? PreviewStorage.storage.getTyped<int?>(key) ?? 0;
    final index = useValueListenable(
      _getField(
        key,
        _PreviewOptionField$Options(
          initialValue,
          name: name,
          key: key,
          options: options,
        ),
      ),
    );
    return options[index];
  }

  PreviewOptionField<T> _getField<T>(String key, PreviewOptionField<T> field) {
    final current = _fields.value[key];
    if (current != null && current.runtimeType == field.runtimeType && current == field) {
      return current as PreviewOptionField<T>;
    }

    final map = _fields.value.plus(key, field);
    _fields.value = map;
    return field;
  }
}

class _DebouncedValueNotifier<T> extends ChangeNotifier implements ValueListenable<T> {
  T _value;
  Timer? _debounceTimer;

  _DebouncedValueNotifier(this._value);

  set value(T newValue) {
    _value = newValue;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: 100),
      () => WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners()),
    );
  }

  @override
  T get value => _value;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

sealed class PreviewOptionField<T> extends ValueNotifier<T> with EquatableMixin {
  PreviewOptionField(super.initial);

  Widget build(BuildContext context);
}

class _PreviewOptionField$Switch extends PreviewOptionField<bool> {
  final String key;
  final String name;

  _PreviewOptionField$Switch(super.initial, {required this.name, required this.key});

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final newValue = useValueListenable(this);
        return SwitchListTile(
          title: Text(name),
          value: newValue,
          onChanged: (next) {
            PreviewStorage.storage.put(key, next);
            value = next;
          },
        );
      },
    );
  }

  @override
  List<Object?> get props => [];
}

class _PreviewOptionField$Input extends PreviewOptionField<String> {
  final String key;
  final String name;
  final List<TextInputFormatter>? formatters;

  _PreviewOptionField$Input(
    super.initial, {
    required this.name,
    required this.key,
    this.formatters,
  });

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final newValue = useValueListenable(this);
        return ListTile(
          title: Text(name),
          subtitle: TextFormField(
            initialValue: newValue,
            inputFormatters: formatters,
            onChanged: (next) {
              PreviewStorage.storage.put(key, next);
              value = next;
            },
          ),
        );
      },
    );
  }

  @override
  List<Object?> get props => [];
}

class _PreviewOptionField$Options extends PreviewOptionField<int> {
  final List<String> options;
  final String name;
  final String key;

  _PreviewOptionField$Options(int initial, {required this.name, required this.key, required this.options})
      : super(
          initial > 0 && initial < options.length ? initial : 0,
        );

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final newValue = useValueListenable(this);
        return ListTile(
          title: Text(name),
          trailing: DropdownButton<int>(
            value: newValue,
            items: options
                .mapIndexed<DropdownMenuItem<int>>((i, e) => DropdownMenuItem(value: i, child: Text(e)))
                .toList(),
            onChanged: (next) {
              if (next == null) return;
              PreviewStorage.storage.put(key, next);
              value = next;
            },
          ),
        );
      },
    );
  }

  @override
  List<Object?> get props => [options];
}
